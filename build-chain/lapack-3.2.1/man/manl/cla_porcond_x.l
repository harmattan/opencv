.TH  CLA_PORCOND_X 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_PORCOND_X - CLA_PORCOND_X Compute the infinity norm condition number of  op(A) * diag(X) where X is a COMPLEX vector
.SH SYNOPSIS
.TP 14
REAL FUNCTION
CLA_PORCOND_X( UPLO, N, A, LDA, AF, LDAF, X, INFO,
WORK, RWORK )
.TP 14
.ti +4
IMPLICIT
NONE
.TP 14
.ti +4
CHARACTER
UPLO
.TP 14
.ti +4
INTEGER
N, LDA, LDAF, INFO
.TP 14
.ti +4
COMPLEX
A( LDA, * ), AF( LDAF, * ), WORK( * ), X( * )
.TP 14
.ti +4
REAL
RWORK( * )
.SH PURPOSE
   CLA_PORCOND_X Computes the infinity norm condition number of
   op(A) * diag(X) where X is a COMPLEX vector.
   WORK is a COMPLEX workspace of size 2*N, and
.br
   RWORK is a REAL workspace of size 3*N.
.br
