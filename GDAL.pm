package Geo::GDAL;

use 5.006001;
use XSLoader () ;
use Exporter;
use strict;
use warnings;

our $VERSION = '0.11';

our @ISA = qw(Exporter) ;

our @EXPORT = qw(
     CPLE_AppDefined CPLE_AssertionFailed CPLE_FileIO
     CPLE_IllegalArg CPLE_NoWriteAccess CPLE_None CPLE_NotSupported
     CPLE_OpenFailed CPLE_OutOfMemory CPLE_UserInterrupt
     CPLE_WrongFormat GDAL_RELEASE_DATE GDAL_VERSION_NUM
     CE_Debug CE_Failure CE_Fatal CE_None CE_Warning
     GA_ReadOnly GA_Update GCI_AlphaBand
     GCI_BlackBand GCI_BlueBand GCI_CyanBand GCI_GrayIndex
     GCI_GreenBand GCI_HueBand GCI_LightnessBand GCI_MagentaBand
     GCI_PaletteIndex GCI_RedBand GCI_SaturationBand GCI_Undefined
     GCI_YellowBand GDT_Byte GDT_CFloat32 GDT_CFloat64 GDT_CInt16
     GDT_CInt32 GDT_Float32 GDT_Float64 GDT_Int16 GDT_Int32
     GDT_TypeCount GDT_UInt16 GDT_UInt32 GDT_Unknown GF_Read
     GF_Write GPI_CMYK GPI_Gray GPI_HLS GPI_RGB 
) ;

our $AUTOLOAD;

sub AUTOLOAD {
    no strict 'refs';
    (my $constname = $AUTOLOAD) =~ s/.*:://;
    die "$AUTOLOAD not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname) ;
    if ($error) {
        my (undef,$file,$line) = caller;
        die "$error at $file line $line.\n";
    }
    *$AUTOLOAD = sub { $val };
    goto &$AUTOLOAD;
}


XSLoader::load('Geo::GDAL', $VERSION) ;
AllRegister() ; # register all available GDAL drivers

1;

package Geo::GDAL::Dataset;

sub DESTROY {
    my $self = shift;
    $self->Close;
}

package Geo::GDAL::RasterBand;

use Carp;

our @Template = (
    "",	 # GDT_Unknown
    "C", # GDT_Byte	
    "S", # GDT_UInt16
    "s", # GDT_Int16
    "L", # GDT_UInt32
    "l", # GDT_Int32
    "f", # GDT_Float32
    "d", # GDT_Float64
) ;

sub Read {
    my ($self, $px, $py, $x_size, $y_size) = @_;
    my @data;
    
    my $type = $self->GetRasterDataType;
    my $tmp = $Template[$type] or croak "Type $type unsupported in Read";
    
    $y_size ||= $x_size ||= 1;

    my $thunk = $self->RasterIO(
	&Geo::GDAL::GF_Read, $px, $py, $x_size, $y_size, undef, $type) ;
    
    my $bytes = $x_size * (Geo::GDAL::GetDataTypeSize($type) / 8) ;
    if ($thunk) {
	for my $y (0 .. $y_size - 1) {
	    push @data, [unpack "$tmp*", substr($thunk, $y * $bytes, $bytes) ];
	}
	return \@data;
    }
    return undef;
}

sub Write {
    my ($self, $px, $py, $data) = @_;
    my $thunk;
    my $type = $self->GetRasterDataType;
    my $tmp = $Template[$type] or croak "Type $type unsupported in Write";
    my $y_size = scalar @$data;
    my $x_size = scalar @{$data->[0]};
    $thunk .= pack("$tmp*", @$_) for @$data;
    $self->RasterIO(
	&Geo::GDAL::GF_Write, $px, $py, $x_size, $y_size, $thunk, $type) ;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Geo::GDAL - Read/write raster-based GIS data with the GDAL library

=head1 SYNOPSIS

  use Geo::GDAL;

  my $data = Geo::GDAL::Open("sample.tif", GA_Update) ;

  my $transform = $data->GetGeoTransform;
  my $inv = Geo::GDAL::InvGeoTransform($transform);
  my ($pixel_x, $pixel_y) =
    Geo::GDAL::ApplyGeoTransform($inv, $geo_x, $geo_y);

  my $band = $data->GetRasterBand(1);
  my $data = $band->Read($pixel_x, $pixel_y, 10, 10);
  my $value = $data->[$x][$y];

  $band->Write($pixel_x, $pixel_y, $data);
    
  my $type = $band->GetRasterDataType; # e.g. GDT_Float32
  my $buf = $band->RasterIO(
    GF_Read, $pixel_x, $pixel_y, 8, 8, GDT_Float32);
  my @stream = unpack("f*", $buf);

=head1 DESCRIPTION

Geo::GDAL uses the powerful Geospatial Data Abstraction Library, or
libgdal, to read and write geospatial raster data from Perl.  Geo::GDAL
provides OO-style classes for basic GDAL constructs, such as drivers,
datasets, raster bands, color tables,

Geo::GDAL can, for example, open a GeoTiff of elevation data, and obtain
the elevation at any point.

This software is ALPHA quality -- the XS bindings aren't done yet, so
a lot may break.  You must have the GDAL library (including development
files) installed before attempting to build and install Geo::GDAL!

=head1 CLASSES

Geo::GDAL attempts to provide bindings for all of the
basic functions in the GDAL C API, which is documented at
L<http://www.remotesensing.org/gdal/gdal_8h.html>. In general, the
"GDAL" prefix has been removed, but the method names are otherwise still
the same.

Geo::GDAL breaks the GDAL C API down into the following packages. The matching
C struct is given in parentheses. Where possible, C functions that take a
particular struct as their first argument have been turned into object methods
in the Perl class matching the C struct.

=head2 Geo::GDAL::Driver (GDALDriverH) 

=head2 Geo::GDAL::Dataset (GDALDriverH) 

=head2 Geo::GDAL::RasterBand (GDALRasterBandH) 

=head2 Geo::GDAL::ColorTable (GDALColorTableH) 

=head2 Geo::GDAL::ColorEntry (GDALColorEntry) 

=head2 Geo::GDAL::OptionDefinition (GDALOptionDefinition) 

=head2 Geo::GDAL::GCP (GDAL_GCP) 

=head2 Geo::GDAL::RPCInfo (GDALRPCInfo) 

=head1 SUPPORTED FUNCTIONS AND METHODS

The functions and methods from the following packages are more or less
expected to work. Other functions and methods may work as expected,
but OTOH, they may not. In particular GCP and ColorEntry support may be
little broken. Support for other functions and methods will be hopefully
added in future releases.

=head2 Geo::GDAL functions


=head3 AllRegister() 
    
Note that Geo::GDAL::AllRegister() is called when Geo::GDAL is imported,
so you do not need to call it yourself.

=head3 ApplyGeoTransform($xform, $pixel, $line) 

Applies the affine transform stored in $xform:

  $x = $xform->[0] + $xform->[1] * $pixel + $xform->[2] * $line;
  $y = $xform->[3] + $xform->[4] * $pixel + $xform->[5] * $line;

Returns ($x, $y). If you pass an inverted affine transform to
ApplyGeoTransform, the $pixel and $line arguments become $x and $y,
and pixel and line values are returned instead.

=head3 GetCacheMax() 

=head3 GetCacheUsed() 

=head3 GetColorInterpretationName() 

=head3 GetDataTypeName() 

=head3 GetDataTypeSize() 

=head3 GetDescription() 

=head3 GetDriver() 

Returns a Geo::GDAL::Driver object.

=head3 GetDriverByName() 

Returns a Geo::GDAL::Driver object.

=head3 GetDriverCount() 

=head3 GetPaletteInterpretationName() 

=head3 InvGeoTransform($transform) 

Takes a reference to a six-element list containing an affine transform.
Returns a reference to a six-element list containing the inverse affine
transform.

=head3 Open($filename, $access) 

Instantiates a Geo::GDAL::Dataset object. Use the GA_ReadOnly and
GA_Update constants to specify read-only versus read/write access.

=head3 OpenShared($filename, $access) 

Returns a Geo::GDAL::Dataset object.

=head3 ReadWorldFile(pszBaseFilename, pszExtension) 

Returns a reference to a six-element list containing the affine transform.

=head3 SetCacheMax($nBytes) 

=head3 SetDescription() 

=head3 VersionInfo() 

=head3 WriteWorldFile($filename, $extension, $transform) 

Takes a filename, a file extension, and a reference to a six-element
list containing the affine transform.


=head2 Geo::GDAL::Driver methods


=head3 DeleteDataset($filename) 

=head3 GetDriverHelpTopic() 

=head3 GetDriverLongName() 

=head3 GetDriverShortName() 


=head2 Geo::GDAL::Dataset methods


=head3 Close() 

Called automatically when a Geo::GDAL::Dataset is destroyed.

=head3 DereferenceDataset() 

=head3 FlushCache() 

=head3 GetAccess() 

=head3 GetDatasetDriver() 

Returns a Geo::GDAL::Driver object.

=head3 GetGeoTransform() 

Returns a reference to a six-element list containing the affine transform.

=head3 GetProjectionRef() 

=head3 GetRasterBand($n) 

Fetch raster band $n. Raster band numbering starts at 1. Returns a Geo::GDAL::RasterBand object.

=head3 GetRasterCount() 

=head3 GetRasterXSize() 

=head3 GetRasterYSize() 

=head3 ReferenceDataset() 

=head3 SetGeoTransform($transform) 

$transform should be a reference to a six-element list containing
the affine transform.

=head3 SetProjection($proj) 


=head2 Geo::GDAL::RasterBand methods


=head3 ComputeRasterMinMax($approxOK) 

Returns ($min, $max).

=head3 FillRaster($realValue, $imaginaryValue) 

=head3 FlushRasterCache() 

=head3 GetBandDataset() 

=head3 GetBandNumber() 

=head3 GetBlockSize() 

Returns ($x_size, $y_size) in pixels.

=head3 GetRasterAccess() 

=head3 GetRasterBandXSize() 

=head3 GetRasterBandYSize() 

=head3 GetRasterCategoryNames() 

Returns a reference to a list of scalars, or undef if no category names
are available.

=head3 GetRasterColorInterpretation() 

=head3 GetRasterColorTable() 

Returns a Geo::GDAL::ColorTable object.

=head3 GetRasterDataType() 

=head3 GetRasterMaximum() 

=head3 GetRasterMetadata() 

Returns a reference to a list of scalars, or undef if no metadata is available.

=head3 GetRasterMinimum() 

=head3 GetRasterNoDataValue() 

=head3 GetRasterSampleOverview($n) 

Returns an overview band of type Geo::GDAL::RasterBand containing at
least $n pixels.

=head3 GetRasterUnitType() 

=head3 HasArbitraryOverviews() 

=head3 RasterIO($RWFlag, $XOff, $YOff, $XSize, $YSize, $Buffer, $DataType) 

Reads or writes a block of data from the raster band $XSize pixels wide
and $YSize pixels high, starting at ($XOff, $YOff) . The data is read
from/written to $Buffer, which should be an ordinary scalar, and is of
type $DataType, which should be one of the GDT_* constants.

When reading, undef may be passed in place of $Buffer, in which case
Geo::GDAL will allocate a scalar and return it. Otherwise, RasterIO() 
returns $Buffer.

$Buffer is a packed scalar. Getting the data in and out of $Buffer
involves using pack() /unpack() and a template matching the data type
specified.

Chances are good you will want to use Geo::GDAL::Dataset's Read() and
Write() helper methods, instead.

=head3 Read($XOff, $YOff, $XSize, $YSize) 

Read data from the raster band starting at pixel ($XOff, $YOff) into
a table of values -- a list of lists. The band's native data type is
used. Returns undef on failure. If $YSize is not provided, the area
is assumed to be square; if $XSize is not provided, only one pixel
is returned.

=head3 ReadBlock($XBlockOff, $YBlockOff) 

Read a "natural" block of data. Returns a packed scalar. You will need
to call GetRasterDataType() to figure out which unpack() template to
unpack the data with. See the gdal.h API documentation for more details.

Chances are good you will want to use Geo::GDAL::Dataset's Read() and
Write() helper methods, instead.

=head3 SetRasterCategoryNames($names) 

$names must be a reference to a list of scalars.

=head3 SetRasterColorInterpretation($interp) 

=head3 SetRasterColorTable($table) 

=head3 SetRasterNoDataValue($val) 

=head3 Write($XOff, $YOff, $Data) 

Writes a table of values (list of lists) into the raster band starting at
pixel ($XOff, $YOff) . The band's native data type is assumed, and floating
point values are truncated as necessary. Returns undef on failure.

=head3 WriteBlock($XBlockOff, $YBlockOff, $Data) 

Write a "natural" block of data from a packed scalar. You will need
to call GetRasterDataType() to figure out which pack() template to
pack the data with. See the gdal.h API documentation for more details.

Chances are good you will want to use Geo::GDAL::Dataset's Read() and
Write() helper methods, instead.

=head1 EXPORT

Geo::GDAL exports a ton of GDAL-related constants by default. Enjoy!

=head1 BUGS

Admittedly tons. The bindings need to be finished. Patches welcome!

=head1 SEE ALSO

GDAL homepage at 

L<http://www.remotesensing.org/gdal/>

In particular you will want to familiarize yourself with the GDAL C API,
which is documented: 

L<http://www.remotesensing.org/gdal/gdal_8h.html>

A tutorial to the API is available at:

L<http://www.remotesensing.org/gdal/gdal_tutorial.html>

Finally, L<http://maps.nocat.net> for which this was written.

=head1 THANKS

Much appreciation is due to Frank Warmerdam for writing the GDAL library,
as well as many other useful Open Source GIS tools. Frank's homepage is
at L<http://gdal.velocet.ca/~warmerda/>.

Appreciation is further due my collaborators Jo Walsh and Rich Gibson for
providing the motivation and moral support. Rich contributed documentation
as well. Also, thanks to Nick Clark and Paul Johnson for answering my
foolish XS questions on #p5p.

=head1 AUTHOR


Schuyler D. Erle E<lt>schuyler@frot.orgE<gt>


=head1 COPYRIGHT AND LICENSE


Copyright (C) 2004 by Schuyler Erle


This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
