.TH  ZLA_SYRCOND_C 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLA_SYRCOND_C - ZLA_SYRCOND_C Compute the infinity norm condition number of  op(A) * inv(diag(C)) where C is a DOUBLE PRECISION vector
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLA_SYRCOND_C( UPLO, N, A, LDA, AF,
LDAF, IPIV, C, CAPPLY, INFO, WORK,
RWORK )
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
INTEGER
IPIV( * )
.TP 17
.ti +4
COMPLEX*16
A( LDA, * ), AF( LDAF, * ), WORK( * )
.TP 17
.ti +4
DOUBLE
PRECISION C( * ), RWORK( * )
.SH PURPOSE
   ZLA_SYRCOND_C Computes the infinity norm condition number of
   op(A) * inv(diag(C)) where C is a DOUBLE PRECISION vector.
.SH ARGUMENTS
.TP 6
C     DOUBLE PRECISION  vector.
.TP 6
WORK  COMPLEX*16 workspace of size 2*N.
RWORK DOUBLE PRECISION workspace of size 3*N.
