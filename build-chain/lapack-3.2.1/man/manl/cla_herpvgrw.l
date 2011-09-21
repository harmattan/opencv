.TH  CLA_HERPVGRW 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_HERPVGRW - computes ..
.SH SYNOPSIS
.TP 14
REAL FUNCTION
CLA_HERPVGRW( UPLO, N, INFO, A, LDA, AF, LDAF, IPIV,
WORK )
.TP 14
.ti +4
IMPLICIT
NONE
.TP 14
.ti +4
CHARACTER*1
UPLO
.TP 14
.ti +4
INTEGER
N, INFO, LDA, LDAF
.TP 14
.ti +4
INTEGER
IPIV( * )
.TP 14
.ti +4
COMPLEX
A( LDA, * ), AF( LDAF, * )
.TP 14
.ti +4
REAL
WORK( * )
.SH PURPOSE
CLA_HERPVGRW computes ... .
.SH ARGUMENTS
