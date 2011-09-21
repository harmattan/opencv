.TH  DLA_SYRPVGRW 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
DLA_SYRPVGRW - computes ..
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION DLA_SYRPVGRW( UPLO, N, INFO, A, LDA, AF,
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
INTEGER
IPIV( * )
.TP 17
.ti +4
DOUBLE
PRECISION A( LDA, * ), AF( LDAF, * ), WORK( * )
.SH PURPOSE
DLA_SYRPVGRW computes ... .
.SH ARGUMENTS
