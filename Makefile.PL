use 5.006001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Geo::GDAL',
    VERSION_FROM      => 'GDAL.pm', # finds $VERSION
    PREREQ_PM         => {'Test::More'  =>  0}, # e.g., Module::Name => 1.1
       AUTHOR         => 'Schuyler D. Erle <schuyler@nocat.net>',
    LIBS              => ['-lgdal'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
if  (eval {require ExtUtils::Constant; 1}) {
  # If you edit these definitions to change the constants used by this module,
  # you will need to use the generated const-c.inc and const-xs.inc
  # files to replace their "fallback" counterparts before distributing your
  # changes.
  my @names = qw(
		 CPLE_AppDefined CPLE_AssertionFailed CPLE_FileIO
		 CPLE_IllegalArg CPLE_NoWriteAccess CPLE_None CPLE_NotSupported
		 CPLE_OpenFailed CPLE_OutOfMemory CPLE_UserInterrupt
		 CPLE_WrongFormat GDAL_RELEASE_DATE GDAL_VERSION_NUM);
  push @names, map { {name => "$_", macro => 1} }
	    qw(  CE_Debug CE_Failure CE_Fatal CE_None CE_Warning
		 GA_ReadOnly GA_Update GCI_AlphaBand
		 GCI_BlackBand GCI_BlueBand GCI_CyanBand GCI_GrayIndex
		 GCI_GreenBand GCI_HueBand GCI_LightnessBand GCI_MagentaBand
		 GCI_PaletteIndex GCI_RedBand GCI_SaturationBand GCI_Undefined
		 GCI_YellowBand GDT_Byte GDT_CFloat32 GDT_CFloat64 GDT_CInt16
		 GDT_CInt32 GDT_Float32 GDT_Float64 GDT_Int16 GDT_Int32
		 GDT_TypeCount GDT_UInt16 GDT_UInt32 GDT_Unknown GF_Read
		 GF_Write GPI_CMYK GPI_Gray GPI_HLS GPI_RGB );
  ExtUtils::Constant::WriteConstants(
                                     NAME         => 'Geo::GDAL',
                                     NAMES        => \@names,
                                     DEFAULT_TYPE => 'IV',
                                     C_FILE       => 'const-c.inc',
                                     XS_FILE      => 'const-xs.inc',
                                  );

}
else {
  use File::Copy;
  use File::Spec;
  foreach my $file ('const-c.inc', 'const-xs.inc') {
    my $fallback = File::Spec->catfile('fallback', $file);
    copy ($fallback, $file) or die "Can't copy $fallback to $file: $!";
  }
}
