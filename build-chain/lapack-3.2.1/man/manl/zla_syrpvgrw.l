.TH  ZLA_SYRPVGRW 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLA_SYRPVGRW - computes ..
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLA_SYRPVGRW( UPLO, N, INFO, A, LDA, AF,
LDAF, IPIV, WORK )
.TP 17
.ti +4
IMPLICIT
NONE
.TP 17
.ti +4
CHARACTER*1
UPLO
.TP 17
.ti +4
INTEGER
N, INFO, LDA, LDAF
.TP 17
.ti +4
COMPLEX*16
A( LDA, * ), AF( LDAF, * )
.TP 17
.ti +4
DOUBLE
PRECISION WORK( * )
.TP 17
.ti +4
INTEGER
IPIV( * )
.SH PURPOSE
ZLA_SYRPVGRW computes ... .
.SH ARGUMENTS
