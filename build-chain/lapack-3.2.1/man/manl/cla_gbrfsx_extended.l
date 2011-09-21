.TH  CLA_GBRFSX_EXTENDED 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_GBRFSX_EXTENDED - computes ..
.SH SYNOPSIS
.TP 31
SUBROUTINE CLA_GBRFSX_EXTENDED
( PREC_TYPE, TRANS_TYPE, N, KL, KU,
NRHS, AB, LDAB, AFB, LDAFB, IPIV,
COLEQU, C, B, LDB, Y, LDY,
BERR_OUT, N_NORMS, ERRS_N, ERRS_C,
RES, AYB, DY, Y_TAIL, RCOND,
ITHRESH, RTHRESH, DZ_UB,
IGNORE_CWISE, INFO )
.TP 31
.ti +4
IMPLICIT
NONE
.TP 31
.ti +4
INTEGER
INFO, LDAB, LDAFB, LDB, LDY, N, KL, KU, NRHS,
PREC_TYPE, TRANS_TYPE, N_NORMS, ITHRESH
.TP 31
.ti +4
LOGICAL
COLEQU, IGNORE_CWISE
.TP 31
.ti +4
REAL
RTHRESH, DZ_UB
.TP 31
.ti +4
INTEGER
IPIV( * )
.TP 31
.ti +4
COMPLEX
AB( LDAB, * ), AFB( LDAFB, * ), B( LDB, * ),
Y( LDY, * ), RES( * ), DY( * ), Y_TAIL( * )
.TP 31
.ti +4
REAL
C( * ), AYB(*), RCOND, BERR_OUT( * ),
ERRS_N( NRHS, * ), ERRS_C( NRHS, * )
.SH PURPOSE
CLA_GBRFSX_EXTENDED computes ... .
.SH ARGUMENTS