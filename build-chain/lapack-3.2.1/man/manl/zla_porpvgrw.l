.TH  ZLA_PORPVGRW 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLA_PORPVGRW - computes ..
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLA_PORPVGRW( UPLO, NCOLS, A, LDA, AF,
LDAF, WORK )
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
NCOLS, LDA, LDAF
.TP 17
.ti +4
COMPLEX*16
A( LDA, * ), AF( LDAF, * )
.TP 17
.ti +4
DOUBLE
PRECISION WORK( * )
.SH PURPOSE
ZLA_PORPVGRW computes ... .
.SH ARGUMENTS
