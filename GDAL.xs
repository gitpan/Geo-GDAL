#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <gdal.h>

#include "const-c.inc"

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL		PREFIX = GDAL

INCLUDE: const-xs.inc

void
GDALAllRegister()

int
GDALDataTypeIsComplex(arg0)
	GDALDataType	arg0

GDALDataType
GDALDataTypeUnion(arg0, arg1)
	GDALDataType	arg0
	GDALDataType	arg1

const char *
GDALDecToDMS(arg0, arg1, arg2)
	double	arg0
	const char *	arg1
	int	arg2

=pod

double
GDALDecToPackedDMS(arg0)
	double	arg0

double
GDALPackedDMSToDec(arg0)
	double	arg0


GDALDataType
GDALGetDataTypeByName(arg0)
	const char *	arg0

=cut

void
GDALDeinitGCPs(arg0, arg1)
	int	arg0
	GDAL_GCP *	arg1

void
GDALDestroyDriverManager()

void
GDALDestroyScaledProgress(arg0)
	void *	arg0

int
GDALDummyProgress(arg0, arg1, arg2)
	double	arg0
	const char *	arg1
	void *	arg2

GDAL_GCP *
GDALDuplicateGCPs(arg0, arg1)
	int	arg0
	const GDAL_GCP *	arg1

int
GDALExtractRPCInfo(arg0, arg1)
	char **	arg0
	GDALRPCInfo *	arg1

int
GDALFlushCacheBlock()

int
GDALGCPsToGeoTransform(nGCPCount, pasGCPs, padfGeoTransform, bApproxOK)
	int	nGCPCount
	const GDAL_GCP *	pasGCPs
	double *	padfGeoTransform
	int	bApproxOK

int
GDALGetCacheMax()

int
GDALGetCacheUsed()

const char *
GDALGetColorInterpretationName(arg0)
	GDALColorInterp	arg0

const char *
GDALGetDataTypeName(arg0)
	GDALDataType	arg0

int
GDALGetDataTypeSize(arg0)
	GDALDataType	arg0

const char *
GDALGetDescription(arg0)
	GDALMajorObjectH	arg0

GDALDriverH
GDALGetDriver(arg0)
	int	arg0

GDALDriverH
GDALGetDriverByName(arg0)
	const char *	arg0

int
GDALGetDriverCount()

char **
GDALGetMetadata(arg0, arg1)
	GDALMajorObjectH	arg0
	const char *	arg1

const char *
GDALGetMetadataItem(arg0, arg1, arg2)
	GDALMajorObjectH	arg0
	const char *	arg1
	const char *	arg2

void
GDALGetOpenDatasets(hDS, pnCount)
	GDALDatasetH ***	hDS
	int *	pnCount

const char *
GDALGetPaletteInterpretationName(arg0)
	GDALPaletteInterp	arg0

void
GDALInitGCPs(arg0, arg1)
	int	arg0
	GDAL_GCP *	arg1

double *
GDALInvGeoTransform( transformIn )
	double * transformIn;
    PREINIT:
	double transformOut[6];
    CODE:
	GDALInvGeoTransform( transformIn, transformOut );
	RETVAL = transformOut;
    OUTPUT:
	RETVAL

GDALDatasetH
GDALOpen(pszFilename, eAccess)
	const char *	pszFilename
	GDALAccess	eAccess

GDALDatasetH
GDALOpenShared(arg0, arg1)
	const char *	arg0
	GDALAccess	arg1

int
GDALReadTabFile(pszBaseFilename, padfGeoTransform, ppszWKT, pnGCPCount, ppasGCPs)
	const char *	pszBaseFilename
	double *	padfGeoTransform
	char **	ppszWKT
	int *	pnGCPCount
	GDAL_GCP **	ppasGCPs

double *
GDALReadWorldFile(pszBaseFilename, pszExtension)
	const char *	pszBaseFilename
	const char *	pszExtension
    PREINIT:
	double padfTransform[6];
	int ok;
    CODE:
	ok = GDALReadWorldFile( 
		pszBaseFilename, pszExtension, padfTransform );
	if (!ok) XSRETURN_UNDEF;
	RETVAL = padfTransform;
    OUTPUT:
	RETVAL

int
GDALScaledProgress(arg0, arg1, arg2)
	double	arg0
	const char *	arg1
	void *	arg2

void
GDALSetCacheMax(nBytes)
	int	nBytes

void
GDALSetColorEntry(arg0, arg1, arg2)
	GDALColorTableH	arg0
	int	arg1
	const GDALColorEntry *	arg2

void
GDALSetDescription(arg0, arg1)
	GDALMajorObjectH	arg0
	const char *	arg1

CPLErr
GDALSetMetadata(arg0, arg1, arg2)
	GDALMajorObjectH	arg0
	char **	arg1
	const char *	arg2

CPLErr
GDALSetMetadataItem(arg0, arg1, arg2, arg3)
	GDALMajorObjectH	arg0
	const char *	arg1
	const char *	arg2
	const char *	arg3

void
GDALSwapWords(pData, nWordSize, nWordCount, nWordSkip)
	void *	pData
	int	nWordSize
	int	nWordCount
	int	nWordSkip

int
GDALTermProgress(arg0, arg1, arg2)
	double	arg0
	const char *	arg1
	void *	arg2

const char *
GDALVersionInfo(arg0)
	const char *	arg0

int
GDALWriteWorldFile(pszBaseFilename, pszExtension, padfGeoTransform)
	const char *	pszBaseFilename
	const char *	pszExtension
	double *	padfGeoTransform

void 
GDALApplyGeoTransform(transform, pixel, line)
	double *	transform
	double		pixel
	double		line
    INIT:
	double x, y;
    PPCODE:
	// GDALApplyGeoTransform( transform, pixel, line, &x, &y );
	x = transform[0] + transform[1] * pixel + transform[2] * line;
	y = transform[3] + transform[4] * pixel + transform[5] * line;
	EXTEND( SP, 2 );
	PUSHs(sv_2mortal(newSVnv( x )));
	PUSHs(sv_2mortal(newSVnv( y )));

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::Dataset		PREFIX = GDAL

CPLErr
GDALAddBand(hDS, eType, papszOptions)
	GDALDatasetH	hDS
	GDALDataType	eType
	char **	papszOptions

CPLErr
GDALBuildOverviews(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
	GDALDatasetH	arg0
	const char *	arg1
	int	arg2
	int *	arg3
	int	arg4
	int *	arg5
	GDALProgressFunc	arg6
	void *	arg7

int
GDALReferenceDataset(arg0)
	GDALDatasetH	arg0

CPLErr
GDALSetProjection(arg0, arg1)
	GDALDatasetH	arg0
	const char *	arg1

CPLErr
GDALSetGCPs(arg0, arg1, arg2, arg3)
	GDALDatasetH	arg0
	int	arg1
	const GDAL_GCP *	arg2
	const char *	arg3

CPLErr
GDALSetGeoTransform(arg0, transform)
	GDALDatasetH	arg0
	double * transform;

GDALDatasetH
GDALCreate(hDriver, arg1, arg2, arg3, arg4, arg5, arg6)
	GDALDriverH	hDriver
	const char *	arg1
	int	arg2
	int	arg3
	int	arg4
	GDALDataType	arg5
	char **	arg6

void
GDALClose(arg0)
	GDALDatasetH	arg0

GDALDatasetH
GDALCreateCopy(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
	GDALDriverH	arg0
	const char *	arg1
	GDALDatasetH	arg2
	int	arg3
	char **	arg4
	GDALProgressFunc	arg5
	void *	arg6

CPLErr
GDALDatasetRasterIO(hDS, eRWFlag, nDSXOff, nDSYOff, nDSXSize, nDSYSize, pBuffer, nBXSize, nBYSize, eBDataType, nBandCount, panBandCount, nPixelSpace, nLineSpace, nBandSpace)
	GDALDatasetH	hDS
	GDALRWFlag	eRWFlag
	int	nDSXOff
	int	nDSYOff
	int	nDSXSize
	int	nDSYSize
	void *	pBuffer
	int	nBXSize
	int	nBYSize
	GDALDataType	eBDataType
	int	nBandCount
	int *	panBandCount
	int	nPixelSpace
	int	nLineSpace
	int	nBandSpace


int
GDALDereferenceDataset(arg0)
	GDALDatasetH	arg0

void
GDALFlushCache(hDS)
	GDALDatasetH	hDS

int
GDALGetAccess(hDS)
	GDALDatasetH	hDS

GDALDriverH
GDALGetDatasetDriver(arg0)
	GDALDatasetH	arg0

int
GDALGetGCPCount(arg0)
	GDALDatasetH	arg0

const char *
GDALGetGCPProjection(arg0)
	GDALDatasetH	arg0

const GDAL_GCP *
GDALGetGCPs(arg0)
	GDALDatasetH	arg0

double *
GDALGetGeoTransform(arg0)
    GDALDatasetH arg0
    PREINIT:
	double padfTransform[6];
	int fail;
    CODE:
	fail = GDALGetGeoTransform( arg0, padfTransform );
	if (fail) XSRETURN_UNDEF;
	RETVAL = padfTransform;
    OUTPUT:
	RETVAL

void *
GDALGetInternalHandle(arg0, arg1)
	GDALDatasetH	arg0
	const char *	arg1

const char *
GDALGetProjectionRef(arg0)
	GDALDatasetH	arg0

GDALRasterBandH
GDALGetRasterBand(arg0, arg1)
	GDALDatasetH	arg0
	int	arg1

int
GDALGetRasterCount(arg0)
	GDALDatasetH	arg0

int
GDALGetRasterXSize(arg0)
	GDALDatasetH	arg0

int
GDALGetRasterYSize(arg0)
	GDALDatasetH	arg0

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::Driver		PREFIX = GDAL


CPLErr
GDALDeleteDataset(arg0, arg1)
	GDALDriverH	arg0
	const char *	arg1

void
GDALDeregisterDriver(arg0)
	GDALDriverH	arg0

const char *
GDALGetDriverHelpTopic(arg0)
	GDALDriverH	arg0

const char *
GDALGetDriverLongName(arg0)
	GDALDriverH	arg0

const char *
GDALGetDriverShortName(arg0)
	GDALDriverH	arg0

int
GDALRegisterDriver(arg0)
	GDALDriverH	arg0

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::ColorTable		PREFIX = GDAL

GDALColorTableH
GDALCloneColorTable(arg0)
	GDALColorTableH	arg0

GDALColorTableH
GDALCreateColorTable(arg0)
	GDALPaletteInterp	arg0

void
GDALDestroyColorTable(arg0)
	GDALColorTableH	arg0

const GDALColorEntry *
GDALGetColorEntry(arg0, arg1)
	GDALColorTableH	arg0
	int	arg1

int
GDALGetColorEntryAsRGB(arg0, arg1, arg2)
	GDALColorTableH	arg0
	int	arg1
	GDALColorEntry *	arg2

int
GDALGetColorEntryCount(arg0)
	GDALColorTableH	arg0

GDALPaletteInterp
GDALGetPaletteInterpretation(arg0)
	GDALColorTableH	arg0

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::RasterBand		PREFIX = GDAL

CPLErr
GDALComputeBandStats(hBand, nSampleStep, pdfMean, pdfStdDev, pfnProgress, pProgressData)
	GDALRasterBandH	hBand
	int	nSampleStep
	double *	pdfMean
	double *	pdfStdDev
	GDALProgressFunc	pfnProgress
	void *	pProgressData

void
GDALComputeRasterMinMax(hBand, bApproxOK)
	GDALRasterBandH	hBand
	int	bApproxOK
    INIT:
	double	adfMinMax[2];
    PPCODE:
	GDALComputeRasterMinMax( hBand, bApproxOK, adfMinMax );
	EXTEND(SP, 2);
	PUSHs(sv_2mortal(newSVnv( adfMinMax[0] )));
	PUSHs(sv_2mortal(newSVnv( adfMinMax[1] )));

GDALDatasetH
GDALGetBandDataset(arg0)
	GDALRasterBandH	arg0

int
GDALGetBandNumber(arg0)
	GDALRasterBandH	arg0

int
GDALGetRandomRasterSample(arg0, arg1, arg2)
	GDALRasterBandH	arg0
	int	arg1
	float *	arg2

GDALAccess
GDALGetRasterAccess(arg0)
	GDALRasterBandH	arg0

int
GDALGetRasterBandXSize(arg0)
	GDALRasterBandH	arg0

int
GDALGetRasterBandYSize(arg0)
	GDALRasterBandH	arg0

char **
GDALGetRasterCategoryNames(arg0)
	GDALRasterBandH	arg0

CPLErr
GDALOverviewMagnitudeCorrection(hBaseBand, nOverviewCount, pahOverviews, pfnProgress, pProgressData)
	GDALRasterBandH	hBaseBand
	int	nOverviewCount
	GDALRasterBandH *	pahOverviews
	GDALProgressFunc	pfnProgress
	void *	pProgressData

SV *
GDALRasterIO(hRBand, eRWFlag, nDSXOff, nDSYOff, nDSXSize, nDSYSize, pBuffer, eBDataType)
	GDALRasterBandH	hRBand
	GDALRWFlag	eRWFlag
	int	nDSXOff
	int	nDSYOff
	int	nDSXSize
	int	nDSYSize
	SV *    pBuffer
	GDALDataType	eBDataType
    INIT:
	I32 buf_size;
	SV *buf;
	CPLErr ok;
    CODE:
	buf_size = (GDALGetDataTypeSize(eBDataType) >> 3) * nDSXSize * nDSYSize;
	if (eRWFlag == GF_Read && pBuffer == &PL_sv_undef) {
	    buf = newSVpv( "", buf_size );
	} else {
	    SvGROW( buf = pBuffer, buf_size );
	}
	ok = GDALRasterIO(  hRBand, eRWFlag, nDSXOff, nDSYOff,
			    nDSXSize, nDSYSize, SvPVX(buf), 
			    nDSXSize, nDSYSize, eBDataType, 0, 0 );
	if ( ok == CE_Failure ) 
	    RETVAL = &PL_sv_undef;
	else
	    RETVAL = buf;

    OUTPUT:
	RETVAL

SV *
GDALReadBlock(arg0, XOff, YOff)
	GDALRasterBandH	arg0
	int	XOff
	int	YOff
    INIT:
	I32 buf_size;
	int x_size, y_size;
	SV * buf;
	CPLErr ok;
    CODE:
	GDALGetBlockSize(arg0, &x_size, &y_size);
	buf_size = (GDALGetDataTypeSize(GDALGetRasterDataType(arg0)) >> 3)
			* x_size * y_size;
	buf = newSVpv( "", buf_size );
	ok = GDALReadBlock( arg0, XOff, YOff, SvPVX(buf) );
	if ( ok == CE_Failure ) 
	    RETVAL = &PL_sv_undef;
	else
	    RETVAL = buf;
    OUTPUT:
	RETVAL

GDALColorInterp
GDALGetRasterColorInterpretation(arg0)
	GDALRasterBandH	arg0

GDALColorTableH
GDALGetRasterColorTable(arg0)
	GDALRasterBandH	arg0

GDALDataType
GDALGetRasterDataType(arg0)
	GDALRasterBandH	arg0

CPLErr
GDALWriteBlock(arg0, arg1, arg2, arg3)
	GDALRasterBandH	arg0
	int	arg1
	int	arg2
	SV *	arg3
    CODE:
	RETVAL = GDALWriteBlock( arg0, arg1, arg2, SvPVX(arg3) );
    OUTPUT:
	RETVAL

CPLErr
GDALSetRasterCategoryNames(arg0, arg1)
	GDALRasterBandH	arg0
	char **	arg1

CPLErr
GDALSetRasterColorInterpretation(arg0, arg1)
	GDALRasterBandH	arg0
	GDALColorInterp	arg1

CPLErr
GDALSetRasterColorTable(arg0, arg1)
	GDALRasterBandH	arg0
	GDALColorTableH	arg1

CPLErr
GDALSetRasterNoDataValue(arg0, arg1)
	GDALRasterBandH	arg0
	double	arg1

CPLErr
GDALGetRasterHistogram(hBand, dfMin, dfMax, nBuckets, panHistogram, bIncludeOutOfRange, bApproxOK, pfnProgress, pProgressData)
	GDALRasterBandH	hBand
	double	dfMin
	double	dfMax
	int	nBuckets
	int *	panHistogram
	int	bIncludeOutOfRange
	int	bApproxOK
	GDALProgressFunc	pfnProgress
	void *	pProgressData

double
GDALGetRasterMaximum(arg0)
	GDALRasterBandH	arg0
    CODE:
	RETVAL = GDALGetRasterMaximum(arg0, NULL);
    OUTPUT:
	RETVAL

=pod


char **
GDALGetRasterMetadata(arg0)
	GDALRasterBandH	arg0

=cut

double
GDALGetRasterMinimum(arg0)
	GDALRasterBandH	arg0
    CODE:
	RETVAL = GDALGetRasterMinimum(arg0, NULL);
    OUTPUT:
	RETVAL

double
GDALGetRasterNoDataValue(arg0, arg1)
	GDALRasterBandH	arg0
	int *	arg1

GDALRasterBandH
GDALGetRasterSampleOverview(arg0, arg1)
	GDALRasterBandH	arg0
	int	arg1

const char *
GDALGetRasterUnitType(arg0)
	GDALRasterBandH	arg0

int
GDALHasArbitraryOverviews(arg0)
	GDALRasterBandH	arg0

GDALRasterBandH
GDALGetOverview(arg0, arg1)
	GDALRasterBandH	arg0
	int	arg1

int
GDALGetOverviewCount(arg0)
	GDALRasterBandH	arg0

void
GDALGetBlockSize(arg0)
	GDALRasterBandH	arg0
    INIT:
	int 	pnXSize;
	int 	pnYSize;
    PPCODE:
	GDALGetBlockSize( arg0, &pnXSize, &pnYSize );
	EXTEND( SP, 2 );
	PUSHs(sv_2mortal(newSVnv( pnXSize )));
	PUSHs(sv_2mortal(newSVnv( pnYSize )));

CPLErr
GDALFlushRasterCache(hBand)
	GDALRasterBandH	hBand


CPLErr
GDALFillRaster(hBand, dfRealValue, dfImaginaryValue)
	GDALRasterBandH	hBand
	double	dfRealValue
	double	dfImaginaryValue


MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::OptionDefinition		PREFIX = GDAL

GDALOptionDefinition *
_to_ptr(THIS)
	GDALOptionDefinition THIS = NO_INIT
    PROTOTYPE: $
    CODE:
	if (sv_derived_from(ST(0), "GDALOptionDefinition")) {
	    STRLEN len;
	    char *s = SvPV((SV*)SvRV(ST(0)), len);
	    if (len != sizeof(THIS))
		croak("Size %d of packed data != expected %d",
			len, sizeof(THIS));
	    RETVAL = (GDALOptionDefinition *)s;
	}
	else
	    croak("THIS is not of type GDALOptionDefinition");
    OUTPUT:
	RETVAL

GDALOptionDefinition
new(CLASS)
	char *CLASS = NO_INIT
    PROTOTYPE: $
    CODE:
	Zero((void*)&RETVAL, sizeof(RETVAL), char);
    OUTPUT:
	RETVAL

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::OptionDefinitionPtr		PREFIX = GDAL

char *
pszOptionName(THIS, __value = NO_INIT)
	GDALOptionDefinition * THIS
	char * __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->pszOptionName = __value;
	RETVAL = THIS->pszOptionName;
    OUTPUT:
	RETVAL

char *
pszValueType(THIS, __value = NO_INIT)
	GDALOptionDefinition * THIS
	char * __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->pszValueType = __value;
	RETVAL = THIS->pszValueType;
    OUTPUT:
	RETVAL

char *
pszDescription(THIS, __value = NO_INIT)
	GDALOptionDefinition * THIS
	char * __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->pszDescription = __value;
	RETVAL = THIS->pszDescription;
    OUTPUT:
	RETVAL

char **
papszOptions(THIS, __value = NO_INIT)
	GDALOptionDefinition * THIS
	char ** __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->papszOptions = __value;
	RETVAL = THIS->papszOptions;
    OUTPUT:
	RETVAL


MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::GCP		PREFIX = GDAL

GDAL_GCP *
_to_ptr(THIS)
	GDAL_GCP THIS = NO_INIT
    PROTOTYPE: $
    CODE:
	if (sv_derived_from(ST(0), "GDAL_GCP")) {
	    STRLEN len;
	    char *s = SvPV((SV*)SvRV(ST(0)), len);
	    if (len != sizeof(THIS))
		croak("Size %d of packed data != expected %d",
			len, sizeof(THIS));
	    RETVAL = (GDAL_GCP *)s;
	}
	else
	    croak("THIS is not of type GDAL_GCP");
    OUTPUT:
	RETVAL

GDAL_GCP
new(CLASS)
	char *CLASS = NO_INIT
    PROTOTYPE: $
    CODE:
	Zero((void*)&RETVAL, sizeof(RETVAL), char);
    OUTPUT:
	RETVAL

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::GCPPtr		PREFIX = GDAL

char *
pszId(THIS, __value = NO_INIT)
	GDAL_GCP * THIS
	char * __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->pszId = __value;
	RETVAL = THIS->pszId;
    OUTPUT:
	RETVAL

char *
pszInfo(THIS, __value = NO_INIT)
	GDAL_GCP * THIS
	char * __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->pszInfo = __value;
	RETVAL = THIS->pszInfo;
    OUTPUT:
	RETVAL

double
dfGCPPixel(THIS, __value = NO_INIT)
	GDAL_GCP * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfGCPPixel = __value;
	RETVAL = THIS->dfGCPPixel;
    OUTPUT:
	RETVAL

double
dfGCPLine(THIS, __value = NO_INIT)
	GDAL_GCP * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfGCPLine = __value;
	RETVAL = THIS->dfGCPLine;
    OUTPUT:
	RETVAL

double
dfGCPX(THIS, __value = NO_INIT)
	GDAL_GCP * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfGCPX = __value;
	RETVAL = THIS->dfGCPX;
    OUTPUT:
	RETVAL

double
dfGCPY(THIS, __value = NO_INIT)
	GDAL_GCP * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfGCPY = __value;
	RETVAL = THIS->dfGCPY;
    OUTPUT:
	RETVAL

double
dfGCPZ(THIS, __value = NO_INIT)
	GDAL_GCP * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfGCPZ = __value;
	RETVAL = THIS->dfGCPZ;
    OUTPUT:
	RETVAL


MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::ColorEntry		PREFIX = GDAL

GDALColorEntry *
_to_ptr(THIS)
	GDALColorEntry THIS = NO_INIT
    PROTOTYPE: $
    CODE:
	if (sv_derived_from(ST(0), "GDALColorEntry")) {
	    STRLEN len;
	    char *s = SvPV((SV*)SvRV(ST(0)), len);
	    if (len != sizeof(THIS))
		croak("Size %d of packed data != expected %d",
			len, sizeof(THIS));
	    RETVAL = (GDALColorEntry *)s;
	}
	else
	    croak("THIS is not of type GDALColorEntry");
    OUTPUT:
	RETVAL

GDALColorEntry
new(CLASS)
	char *CLASS = NO_INIT
    PROTOTYPE: $
    CODE:
	Zero((void*)&RETVAL, sizeof(RETVAL), char);
    OUTPUT:
	RETVAL

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::ColorEntryPtr		PREFIX = GDAL

short
c1(THIS, __value = NO_INIT)
	GDALColorEntry * THIS
	short __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->c1 = __value;
	RETVAL = THIS->c1;
    OUTPUT:
	RETVAL

short
c2(THIS, __value = NO_INIT)
	GDALColorEntry * THIS
	short __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->c2 = __value;
	RETVAL = THIS->c2;
    OUTPUT:
	RETVAL

short
c3(THIS, __value = NO_INIT)
	GDALColorEntry * THIS
	short __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->c3 = __value;
	RETVAL = THIS->c3;
    OUTPUT:
	RETVAL

short
c4(THIS, __value = NO_INIT)
	GDALColorEntry * THIS
	short __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->c4 = __value;
	RETVAL = THIS->c4;
    OUTPUT:
	RETVAL


MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::RPCInfo		PREFIX = GDAL

GDALRPCInfo *
_to_ptr(THIS)
	GDALRPCInfo THIS = NO_INIT
    PROTOTYPE: $
    CODE:
	if (sv_derived_from(ST(0), "GDALRPCInfo")) {
	    STRLEN len;
	    char *s = SvPV((SV*)SvRV(ST(0)), len);
	    if (len != sizeof(THIS))
		croak("Size %d of packed data != expected %d",
			len, sizeof(THIS));
	    RETVAL = (GDALRPCInfo *)s;
	}
	else
	    croak("THIS is not of type GDALRPCInfo");
    OUTPUT:
	RETVAL

GDALRPCInfo
new(CLASS)
	char *CLASS = NO_INIT
    PROTOTYPE: $
    CODE:
	Zero((void*)&RETVAL, sizeof(RETVAL), char);
    OUTPUT:
	RETVAL

MODULE = Geo::GDAL		PACKAGE = Geo::GDAL::RPCInfoPtr		PREFIX = GDAL

double
dfLINE_OFF(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfLINE_OFF = __value;
	RETVAL = THIS->dfLINE_OFF;
    OUTPUT:
	RETVAL

double
dfSAMP_OFF(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfSAMP_OFF = __value;
	RETVAL = THIS->dfSAMP_OFF;
    OUTPUT:
	RETVAL

double
dfLAT_OFF(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfLAT_OFF = __value;
	RETVAL = THIS->dfLAT_OFF;
    OUTPUT:
	RETVAL

double
dfLONG_OFF(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfLONG_OFF = __value;
	RETVAL = THIS->dfLONG_OFF;
    OUTPUT:
	RETVAL

double
dfHEIGHT_OFF(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfHEIGHT_OFF = __value;
	RETVAL = THIS->dfHEIGHT_OFF;
    OUTPUT:
	RETVAL

double
dfLINE_SCALE(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfLINE_SCALE = __value;
	RETVAL = THIS->dfLINE_SCALE;
    OUTPUT:
	RETVAL

double
dfSAMP_SCALE(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfSAMP_SCALE = __value;
	RETVAL = THIS->dfSAMP_SCALE;
    OUTPUT:
	RETVAL

double
dfLAT_SCALE(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfLAT_SCALE = __value;
	RETVAL = THIS->dfLAT_SCALE;
    OUTPUT:
	RETVAL

double
dfLONG_SCALE(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfLONG_SCALE = __value;
	RETVAL = THIS->dfLONG_SCALE;
    OUTPUT:
	RETVAL

double
dfHEIGHT_SCALE(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfHEIGHT_SCALE = __value;
	RETVAL = THIS->dfHEIGHT_SCALE;
    OUTPUT:
	RETVAL


double
dfMIN_LONG(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfMIN_LONG = __value;
	RETVAL = THIS->dfMIN_LONG;
    OUTPUT:
	RETVAL

double
dfMIN_LAT(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfMIN_LAT = __value;
	RETVAL = THIS->dfMIN_LAT;
    OUTPUT:
	RETVAL

double
dfMAX_LONG(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfMAX_LONG = __value;
	RETVAL = THIS->dfMAX_LONG;
    OUTPUT:
	RETVAL

double
dfMAX_LAT(THIS, __value = NO_INIT)
	GDALRPCInfo * THIS
	double __value
    PROTOTYPE: $;$
    CODE:
	if (items > 1)
	    THIS->dfMAX_LAT = __value;
	RETVAL = THIS->dfMAX_LAT;
    OUTPUT:
	RETVAL

