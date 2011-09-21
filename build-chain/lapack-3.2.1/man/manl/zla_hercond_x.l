.TH  ZLA_HERCOND_X 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLA_HERCOND_X - ZLA_HERCOND_X compute the infinity norm condition number of  op(A) * diag(X) where X is a COMPLEX*16 vector
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLA_HERCOND_X( UPLO, N, A, LDA, AF,
LDAF, IPIV, X, INFO, WORK, RWORK )
.TP 17
.ti +4
IMPLICIT
NONE
.TP 17
.ti +4
CHARACTER
UPLO
.TP 17
.ti +4
INTEGER
N, LDA, LDAF, INFO
.TP 17
.ti +4
INTEGER
IPIV( * )
.TP 17
.ti +4
COMPLEX*16
A( LDA, * ), AF( LDAF, * ), WORK( * ), X( * )
.TP 17
.ti +4
DOUBLE
PRECISION RWORK( * )
.SH PURPOSE
   ZLA_HERCOND_X computes the infinity norm condition number of
   op(A) * diag(X) where X is a COMPLEX*16 vector.
.SH ARGUMENTS
.TP 6
C     COMPLEX*16 vector.
.TP 6
WORK  COMPLEX*16 workspace of size 2*N.
RWORK DOUBLE PRECISION workspace of size 3*N.
