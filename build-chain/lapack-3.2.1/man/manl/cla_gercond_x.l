.TH  CLA_GERCOND_X 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_GERCOND_X - CLA_GERCOND_X compute the infinity norm condition number of  op(A) * diag(X) where X is a COMPLEX vector
.SH SYNOPSIS
.TP 14
REAL FUNCTION
CLA_GERCOND_X( TRANS, N, A, LDA, AF, LDAF, IPIV, X,
INFO, WORK, RWORK )
.TP 14
.ti +4
IMPLICIT
NONE
.TP 14
.ti +4
CHARACTER
TRANS
.TP 14
.ti +4
INTEGER
N, LDA, LDAF, INFO
.TP 14
.ti +4
INTEGER
IPIV( * )
.TP 14
.ti +4
COMPLEX
A( LDA, * ), AF( LDAF, * ), WORK( * ), X( * )
.TP 14
.ti +4
REAL
RWORK( * )
.SH PURPOSE
   CLA_GERCOND_X computes the infinity norm condition number of
   op(A) * diag(X) where X is a COMPLEX vector.
.SH ARGUMENTS
.TP 8
X       COMPLEX vector.
.TP 8
WORK    COMPLEX workspace of size 2*N.
.TP 8
RWORK   REAL workspace of size 3*N.
