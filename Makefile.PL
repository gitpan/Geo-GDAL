use ExtUtils::MakeMaker;

$libdir = $ENV{'PREFIX'} ? "-L$ENV{'PREFIX'}/lib" : '';

$libdir .= "-L/msys/1.0/local/lib";

$ext = $^O eq 'MSWin32' ? '.dll' : '';

%object = ( 'Geo::GDAL' => 'gdal_wrap.o',
	    'Geo::GDAL::Const' => 'gdalconst_wrap.o',
	    'Geo::OGR' => 'ogr_wrap.o',
	    'Geo::OSR' => 'osr_wrap.o' );

for my $module (keys %object) {
    my $add = $module;
    $add =~ s/:/_/g;
    my $Makefile = $module eq 'Geo::GDAL' ? 'Makefile' : 'Makefile_'.$add;
    WriteMakefile( NAME => $module,
		   VERSION_FROM => 'lib/Geo/GDAL.pm',
		   MAKEFILE => $Makefile,
		   LIBS => "$libdir -L../../.libs -lgdal$ext -lgeos$ext -lgeos_c$ext",
		   INC => '-I../../gcore -I../../alg -I../../ogr -I../../port',
		   OBJECT => $object{$module}
		   );
}
