.TH  ZLA_PORCOND_C 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLA_PORCOND_C - DLA_PORCOND_C Compute the infinity norm condition number of  op(A) * inv(diag(C)) where C is a DOUBLE PRECISION vector  Arguments =========  C DOUBLE PRECISION vector
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLA_PORCOND_C( UPLO, N, A, LDA, AF,
LDAF, C, CAPPLY, INFO, WORK, RWORK )
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
LOGICAL
CAPPLY
.TP 17
.ti +4
INTEGER
N, LDA, LDAF, INFO
.TP 17
.ti +4
COMPLEX*16
A( LDA, * ), AF( LDAF, * ), WORK( * )
.TP 17
.ti +4
DOUBLE
PRECISION C( * ), RWORK( * )
.SH PURPOSE
   DLA_PORCOND_C Computes the infinity norm condition number of
   op(A) * inv(diag(C)) where C is a DOUBLE PRECISION vector
WORK  COMPLEX*16 workspace of size 2*N.
.br
RWORK DOUBLE PRECISION workspace of size 3*N.
.br
