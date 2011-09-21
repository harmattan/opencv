.TH  CLA_PORCOND_C 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_PORCOND_C - SLA_PORCOND_C Compute the infinity norm condition number of  op(A) * inv(diag(C)) where C is a REAL vector  WORK is a COMPLEX workspace of size 2*N, and  RWORK is a REAL workspace of size 3*N
.SH SYNOPSIS
.TP 14
REAL FUNCTION
CLA_PORCOND_C( UPLO, N, A, LDA, AF, LDAF, C, CAPPLY,
INFO, WORK, RWORK )
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
LOGICAL
CAPPLY
.TP 14
.ti +4
INTEGER
N, LDA, LDAF, INFO
.TP 14
.ti +4
COMPLEX
A( LDA, * ), AF( LDAF, * ), WORK( * )
.TP 14
.ti +4
REAL
C( * ), RWORK( * )
.SH PURPOSE
   SLA_PORCOND_C Computes the infinity norm condition number of
   op(A) * inv(diag(C)) where C is a REAL vector
   WORK is a COMPLEX workspace of size 2*N, and
   RWORK is a REAL workspace of size 3*N.
