.TH  DLA_PORPVGRW 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
DLA_PORPVGRW - computes ..
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION DLA_PORPVGRW( UPLO, NCOLS, A, LDA, AF,
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
DOUBLE
PRECISION A( LDA, * ), AF( LDAF, * ), WORK( * )
.SH PURPOSE
DLA_PORPVGRW computes ... .
.SH ARGUMENTS
