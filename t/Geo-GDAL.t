# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Geo-GDAL.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use blib;
use FindBin;
use Test::More 'no_plan';
use strict;
use warnings;

BEGIN { use_ok('Geo::GDAL') };

my $fail = 0;
foreach my $constname (qw(
	CE_Debug CE_Failure CE_Fatal CE_None CE_Warning CPLE_AppDefined
	CPLE_AssertionFailed CPLE_FileIO CPLE_IllegalArg CPLE_NoWriteAccess
	CPLE_None CPLE_NotSupported CPLE_OpenFailed CPLE_OutOfMemory
	CPLE_UserInterrupt CPLE_WrongFormat GA_ReadOnly GA_Update GCI_AlphaBand
	GCI_BlackBand GCI_BlueBand GCI_CyanBand GCI_GrayIndex GCI_GreenBand
	GCI_HueBand GCI_LightnessBand GCI_MagentaBand GCI_PaletteIndex
	GCI_RedBand GCI_SaturationBand GCI_Undefined GCI_YellowBand GDT_Byte
	GDT_CFloat32 GDT_CFloat64 GDT_CInt16 GDT_CInt32 GDT_Float32 GDT_Float64
	GDT_Int16 GDT_Int32 GDT_TypeCount GDT_UInt16 GDT_UInt32 GDT_Unknown
	GF_Read GF_Write GPI_CMYK GPI_Gray GPI_HLS GPI_RGB
	GDAL_RELEASE_DATE GDAL_VERSION_NUM)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined Geo::GDAL macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $data = Geo::GDAL::Open( "$FindBin::Bin/sample.tif", GA_Update );
isa_ok( $data, "Geo::GDAL::Dataset", "sample GTiff" );

is( $data->GetRasterXSize, 82, "GetRasterXSize" );
is( $data->GetRasterYSize, 58, "GetRasterYSize" );

my $transform = $data->GetGeoTransform;
is_deeply(  $transform, 
	    [ '545975', '10', '0', '4184765', '0', '-10' ],
	    "GetGeoTransform" );

is( $data->SetGeoTransform($transform), CE_None, "SetGeoTransform" );

my $inv = Geo::GDAL::InvGeoTransform($transform);
is_deeply( $inv,  
	    [ '-54597.5', '0.1', '0', '418476.5', '0', '-0.1' ],
	    "InvGeoTransform" );

my $driver = $data->GetDatasetDriver;
isa_ok( $driver, "Geo::GDAL::Driver", "driver" );
is( $driver->GetDriverShortName, "GTiff", "GetDriverShortName" );
is( $driver->GetDriverLongName, "GeoTIFF", "GetDriverLongName" );

my $band = $data->GetRasterBand( 1 );
isa_ok( $band, "Geo::GDAL::RasterBand", "raster band" );

my $type = $band->GetRasterDataType;
is( Geo::GDAL::GetDataTypeName($type), "Float32", "GetRasterDataType" );

$type = $band->GetRasterColorInterpretation;
is( Geo::GDAL::GetColorInterpretationName($type), "Gray", 
    "GetRasterColorInterpretation" );

$type = $band->GetRasterColorTable;
is( $type, undef, "GeoTIFF doesn't have a color table" );
# is( $type->GetColorEntryCount, "", "GetColorEntryCount" );

my $meta = $band->GetRasterCategoryNames;
is($meta, undef, "GeoTIFF doesn't have category names" );

my ($min, $max) = ($band->GetRasterMinimum, $band->GetRasterMaximum);
is( $min, -4294967295, "GetRasterMinimum" );
is( $max, 4294967295, "GetRasterMaximum" );

($min, $max) = $band->ComputeRasterMinMax(0);
is( $min, 0, "ComputeRasterMinMax min" );
is( $max, 204, "ComputeRasterMinMax min" );

my ($xsize, $ysize) = $band->GetBlockSize;
is( $xsize, 82, "GetBlockSize x" );
is( $ysize, 24, "GetBlockSize y" );

my ($x, $y) = Geo::GDAL::ApplyGeoTransform( $inv, 546055, 4184700 );
is( int $x, 8, "ApplyGeoTransform x" );
is( $y, 6.5, "ApplyGeoTransform y" );

my $buf = $band->RasterIO( GF_Read, $x, $y, 6, 6, undef, GDT_Float32 );
isnt( $buf, undef, "RasterIO succeeds" );
is( length $buf, 144, "RasterIO reads correct length" );

my @elev = unpack( "f*", $buf );
is( $elev[0], 0, "RasterIO gets correct value 1" );
is( $elev[1 * 6 + 1], 0, "RasterIO gets correct value 2" );
is( $elev[2 * 6 + 2], 21, "RasterIO gets correct value 3" );
is( $elev[3 * 6 + 3], 38, "RasterIO gets correct value 4" );
is( $elev[4 * 6 + 4], 52, "RasterIO gets correct value 5" );
is( $elev[5 * 6 + 5], 61, "RasterIO gets correct value 6" );

my $elev = $band->Read( $x, $y, 6, 6 );
is( $elev->[0][0], 0, "Read gets correct value 1" );
is( $elev->[1][1], 0, "Read gets correct value 2" );
is( $elev->[2][2], 21, "Read gets correct value 3" );
is( $elev->[3][3], 38, "Read gets correct value 4" );
is( $elev->[4][4], 52, "Read gets correct value 5" );
is( $elev->[5][5], 61, "Read gets correct value 6" );

