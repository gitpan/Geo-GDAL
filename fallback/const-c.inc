#define PERL_constant_NOTFOUND	1
#define PERL_constant_NOTDEF	2
#define PERL_constant_ISIV	3
#define PERL_constant_ISNO	4
#define PERL_constant_ISNV	5
#define PERL_constant_ISPV	6
#define PERL_constant_ISPVN	7
#define PERL_constant_ISSV	8
#define PERL_constant_ISUNDEF	9
#define PERL_constant_ISUV	10
#define PERL_constant_ISYES	11

#ifndef NVTYPE
typedef double NV; /* 5.6 and later define NVTYPE, and typedef NV to it.  */
#endif
#ifndef aTHX_
#define aTHX_ /* 5.6 or later define this for threading support.  */
#endif
#ifndef pTHX_
#define pTHX_ /* 5.6 or later define this for threading support.  */
#endif

static int
constant_7 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CE_None GF_Read GPI_HLS GPI_RGB */
  /* Offset 6 gives the best switch position.  */
  switch (name[6]) {
  case 'B':
    if (memEQ(name, "GPI_RG", 6)) {
    /*                     B     */
#ifdef GPI_RGB
      *iv_return = GPI_RGB;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'S':
    if (memEQ(name, "GPI_HL", 6)) {
    /*                     S     */
#ifdef GPI_HLS
      *iv_return = GPI_HLS;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'd':
    if (memEQ(name, "GF_Rea", 6)) {
    /*                     d     */
#ifdef GF_Read
      *iv_return = GF_Read;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'e':
    if (memEQ(name, "CE_Non", 6)) {
    /*                     e     */
#ifdef CE_None
      *iv_return = CE_None;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_8 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CE_Debug CE_Fatal GDT_Byte GF_Write GPI_CMYK GPI_Gray */
  /* Offset 5 gives the best switch position.  */
  switch (name[5]) {
  case 'M':
    if (memEQ(name, "GPI_CMYK", 8)) {
    /*                    ^        */
#ifdef GPI_CMYK
      *iv_return = GPI_CMYK;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'b':
    if (memEQ(name, "CE_Debug", 8)) {
    /*                    ^        */
#ifdef CE_Debug
      *iv_return = CE_Debug;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'i':
    if (memEQ(name, "GF_Write", 8)) {
    /*                    ^        */
#ifdef GF_Write
      *iv_return = GF_Write;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'r':
    if (memEQ(name, "GPI_Gray", 8)) {
    /*                    ^        */
#ifdef GPI_Gray
      *iv_return = GPI_Gray;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 't':
    if (memEQ(name, "CE_Fatal", 8)) {
    /*                    ^        */
#ifdef CE_Fatal
      *iv_return = CE_Fatal;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'y':
    if (memEQ(name, "GDT_Byte", 8)) {
    /*                    ^        */
#ifdef GDT_Byte
      *iv_return = GDT_Byte;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_9 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CPLE_None GA_Update GDT_Int16 GDT_Int32 */
  /* Offset 7 gives the best switch position.  */
  switch (name[7]) {
  case '1':
    if (memEQ(name, "GDT_Int16", 9)) {
    /*                      ^       */
#ifdef GDT_Int16
      *iv_return = GDT_Int16;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case '3':
    if (memEQ(name, "GDT_Int32", 9)) {
    /*                      ^       */
#ifdef GDT_Int32
      *iv_return = GDT_Int32;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'n':
    if (memEQ(name, "CPLE_None", 9)) {
    /*                      ^       */
#ifdef CPLE_None
      *iv_return = CPLE_None;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 't':
    if (memEQ(name, "GA_Update", 9)) {
    /*                      ^       */
#ifdef GA_Update
      *iv_return = GA_Update;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_10 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CE_Failure CE_Warning GDT_CInt16 GDT_CInt32 GDT_UInt16 GDT_UInt32 */
  /* Offset 9 gives the best switch position.  */
  switch (name[9]) {
  case '2':
    if (memEQ(name, "GDT_CInt3", 9)) {
    /*                        2     */
#ifdef GDT_CInt32
      *iv_return = GDT_CInt32;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "GDT_UInt3", 9)) {
    /*                        2     */
#ifdef GDT_UInt32
      *iv_return = GDT_UInt32;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case '6':
    if (memEQ(name, "GDT_CInt1", 9)) {
    /*                        6     */
#ifdef GDT_CInt16
      *iv_return = GDT_CInt16;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "GDT_UInt1", 9)) {
    /*                        6     */
#ifdef GDT_UInt16
      *iv_return = GDT_UInt16;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'e':
    if (memEQ(name, "CE_Failur", 9)) {
    /*                        e     */
#ifdef CE_Failure
      *iv_return = CE_Failure;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'g':
    if (memEQ(name, "CE_Warnin", 9)) {
    /*                        g     */
#ifdef CE_Warning
      *iv_return = CE_Warning;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_11 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CPLE_FileIO GA_ReadOnly GCI_HueBand GCI_RedBand GDT_Float32 GDT_Float64
     GDT_Unknown */
  /* Offset 4 gives the best switch position.  */
  switch (name[4]) {
  case 'F':
    if (memEQ(name, "GDT_Float32", 11)) {
    /*                   ^             */
#ifdef GDT_Float32
      *iv_return = GDT_Float32;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "GDT_Float64", 11)) {
    /*                   ^             */
#ifdef GDT_Float64
      *iv_return = GDT_Float64;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'H':
    if (memEQ(name, "GCI_HueBand", 11)) {
    /*                   ^             */
#ifdef GCI_HueBand
      *iv_return = GCI_HueBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'R':
    if (memEQ(name, "GCI_RedBand", 11)) {
    /*                   ^             */
#ifdef GCI_RedBand
      *iv_return = GCI_RedBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'U':
    if (memEQ(name, "GDT_Unknown", 11)) {
    /*                   ^             */
#ifdef GDT_Unknown
      *iv_return = GDT_Unknown;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case '_':
    if (memEQ(name, "CPLE_FileIO", 11)) {
    /*                   ^             */
#ifdef CPLE_FileIO
      *iv_return = CPLE_FileIO;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'e':
    if (memEQ(name, "GA_ReadOnly", 11)) {
    /*                   ^             */
#ifdef GA_ReadOnly
      *iv_return = GA_ReadOnly;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_12 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     GCI_BlueBand GCI_CyanBand GDT_CFloat32 GDT_CFloat64 _VERSION_NUM */
  /* Offset 7 gives the best switch position.  */
  switch (name[7]) {
  case 'N':
    if (memEQ(name, "_VERSION_NUM", 12)) {
    /*                      ^           */
#ifdef _VERSION_NUM
      *iv_return = _VERSION_NUM;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'e':
    if (memEQ(name, "GCI_BlueBand", 12)) {
    /*                      ^           */
#ifdef GCI_BlueBand
      *iv_return = GCI_BlueBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'n':
    if (memEQ(name, "GCI_CyanBand", 12)) {
    /*                      ^           */
#ifdef GCI_CyanBand
      *iv_return = GCI_CyanBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'o':
    if (memEQ(name, "GDT_CFloat32", 12)) {
    /*                      ^           */
#ifdef GDT_CFloat32
      *iv_return = GDT_CFloat32;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    if (memEQ(name, "GDT_CFloat64", 12)) {
    /*                      ^           */
#ifdef GDT_CFloat64
      *iv_return = GDT_CFloat64;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_13 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     GCI_AlphaBand GCI_BlackBand GCI_GrayIndex GCI_GreenBand GCI_Undefined
     GDT_TypeCount _RELEASE_DATE */
  /* Offset 8 gives the best switch position.  */
  switch (name[8]) {
  case 'C':
    if (memEQ(name, "GDT_TypeCount", 13)) {
    /*                       ^           */
#ifdef GDT_TypeCount
      *iv_return = GDT_TypeCount;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'I':
    if (memEQ(name, "GCI_GrayIndex", 13)) {
    /*                       ^           */
#ifdef GCI_GrayIndex
      *iv_return = GCI_GrayIndex;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case '_':
    if (memEQ(name, "_RELEASE_DATE", 13)) {
    /*                       ^           */
#ifdef _RELEASE_DATE
      *iv_return = _RELEASE_DATE;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'a':
    if (memEQ(name, "GCI_AlphaBand", 13)) {
    /*                       ^           */
#ifdef GCI_AlphaBand
      *iv_return = GCI_AlphaBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'f':
    if (memEQ(name, "GCI_Undefined", 13)) {
    /*                       ^           */
#ifdef GCI_Undefined
      *iv_return = GCI_Undefined;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'k':
    if (memEQ(name, "GCI_BlackBand", 13)) {
    /*                       ^           */
#ifdef GCI_BlackBand
      *iv_return = GCI_BlackBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'n':
    if (memEQ(name, "GCI_GreenBand", 13)) {
    /*                       ^           */
#ifdef GCI_GreenBand
      *iv_return = GCI_GreenBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_15 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CPLE_AppDefined CPLE_IllegalArg CPLE_OpenFailed GCI_MagentaBand */
  /* Offset 5 gives the best switch position.  */
  switch (name[5]) {
  case 'A':
    if (memEQ(name, "CPLE_AppDefined", 15)) {
    /*                    ^                */
#ifdef CPLE_AppDefined
      *iv_return = CPLE_AppDefined;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'I':
    if (memEQ(name, "CPLE_IllegalArg", 15)) {
    /*                    ^                */
#ifdef CPLE_IllegalArg
      *iv_return = CPLE_IllegalArg;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'O':
    if (memEQ(name, "CPLE_OpenFailed", 15)) {
    /*                    ^                */
#ifdef CPLE_OpenFailed
      *iv_return = CPLE_OpenFailed;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'a':
    if (memEQ(name, "GCI_MagentaBand", 15)) {
    /*                    ^                */
#ifdef GCI_MagentaBand
      *iv_return = GCI_MagentaBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_16 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CPLE_OutOfMemory CPLE_WrongFormat GCI_PaletteIndex */
  /* Offset 15 gives the best switch position.  */
  switch (name[15]) {
  case 't':
    if (memEQ(name, "CPLE_WrongForma", 15)) {
    /*                              t      */
#ifdef CPLE_WrongFormat
      *iv_return = CPLE_WrongFormat;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'x':
    if (memEQ(name, "GCI_PaletteInde", 15)) {
    /*                              x      */
#ifdef GCI_PaletteIndex
      *iv_return = GCI_PaletteIndex;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 'y':
    if (memEQ(name, "CPLE_OutOfMemor", 15)) {
    /*                              y      */
#ifdef CPLE_OutOfMemory
      *iv_return = CPLE_OutOfMemory;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant_18 (pTHX_ const char *name, IV *iv_return) {
  /* When generated this function returned values for the list of names given
     here.  However, subsequent manual editing may have added or removed some.
     CPLE_NoWriteAccess CPLE_UserInterrupt GCI_SaturationBand */
  /* Offset 6 gives the best switch position.  */
  switch (name[6]) {
  case 'o':
    if (memEQ(name, "CPLE_NoWriteAccess", 18)) {
    /*                     ^                  */
#ifdef CPLE_NoWriteAccess
      *iv_return = CPLE_NoWriteAccess;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 's':
    if (memEQ(name, "CPLE_UserInterrupt", 18)) {
    /*                     ^                  */
#ifdef CPLE_UserInterrupt
      *iv_return = CPLE_UserInterrupt;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 't':
    if (memEQ(name, "GCI_SaturationBand", 18)) {
    /*                     ^                  */
#ifdef GCI_SaturationBand
      *iv_return = GCI_SaturationBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

static int
constant (pTHX_ const char *name, STRLEN len, IV *iv_return) {
  /* Initially switch on the length of the name.  */
  /* When generated this function returned values for the list of names given
     in this section of perl code.  Rather than manually editing these functions
     to add or remove constants, which would result in this comment and section
     of code becoming inaccurate, we recommend that you edit this section of
     code, and use it to regenerate a new set of constant functions which you
     then use to replace the originals.

     Regenerate these constant functions by feeding this entire source file to
     perl -x

#!/usr/bin/perl -w
use ExtUtils::Constant qw (constant_types C_constant XS_constant);

my $types = {map {($_, 1)} qw(IV)};
my @names = (qw(CE_Debug CE_Failure CE_Fatal CE_None CE_Warning CPLE_AppDefined
	       CPLE_AssertionFailed CPLE_FileIO CPLE_IllegalArg
	       CPLE_NoWriteAccess CPLE_None CPLE_NotSupported CPLE_OpenFailed
	       CPLE_OutOfMemory CPLE_UserInterrupt CPLE_WrongFormat GA_ReadOnly
	       GA_Update GCI_AlphaBand GCI_BlackBand GCI_BlueBand GCI_CyanBand
	       GCI_GrayIndex GCI_GreenBand GCI_HueBand GCI_LightnessBand
	       GCI_MagentaBand GCI_PaletteIndex GCI_RedBand GCI_SaturationBand
	       GCI_Undefined GCI_YellowBand GDT_Byte GDT_CFloat32 GDT_CFloat64
	       GDT_CInt16 GDT_CInt32 GDT_Float32 GDT_Float64 GDT_Int16
	       GDT_Int32 GDT_TypeCount GDT_UInt16 GDT_UInt32 GDT_Unknown
	       GF_Read GF_Write GPI_CMYK GPI_Gray GPI_HLS GPI_RGB _RELEASE_DATE
	       _VERSION_NUM));

print constant_types(); # macro defs
foreach (C_constant ("Geo::GDAL", 'constant', 'IV', $types, undef, 3, @names) ) {
    print $_, "\n"; # C constant subs
}
print "#### XS Section:\n";
print XS_constant ("Geo::GDAL", $types);
__END__
   */

  switch (len) {
  case 7:
    return constant_7 (aTHX_ name, iv_return);
    break;
  case 8:
    return constant_8 (aTHX_ name, iv_return);
    break;
  case 9:
    return constant_9 (aTHX_ name, iv_return);
    break;
  case 10:
    return constant_10 (aTHX_ name, iv_return);
    break;
  case 11:
    return constant_11 (aTHX_ name, iv_return);
    break;
  case 12:
    return constant_12 (aTHX_ name, iv_return);
    break;
  case 13:
    return constant_13 (aTHX_ name, iv_return);
    break;
  case 14:
    if (memEQ(name, "GCI_YellowBand", 14)) {
#ifdef GCI_YellowBand
      *iv_return = GCI_YellowBand;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  case 15:
    return constant_15 (aTHX_ name, iv_return);
    break;
  case 16:
    return constant_16 (aTHX_ name, iv_return);
    break;
  case 17:
    /* Names all of length 17.  */
    /* CPLE_NotSupported GCI_LightnessBand */
    /* Offset 2 gives the best switch position.  */
    switch (name[2]) {
    case 'I':
      if (memEQ(name, "GCI_LightnessBand", 17)) {
      /*                 ^                     */
#ifdef GCI_LightnessBand
        *iv_return = GCI_LightnessBand;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    case 'L':
      if (memEQ(name, "CPLE_NotSupported", 17)) {
      /*                 ^                     */
#ifdef CPLE_NotSupported
        *iv_return = CPLE_NotSupported;
        return PERL_constant_ISIV;
#else
        return PERL_constant_NOTDEF;
#endif
      }
      break;
    }
    break;
  case 18:
    return constant_18 (aTHX_ name, iv_return);
    break;
  case 20:
    if (memEQ(name, "CPLE_AssertionFailed", 20)) {
#ifdef CPLE_AssertionFailed
      *iv_return = CPLE_AssertionFailed;
      return PERL_constant_ISIV;
#else
      return PERL_constant_NOTDEF;
#endif
    }
    break;
  }
  return PERL_constant_NOTFOUND;
}

