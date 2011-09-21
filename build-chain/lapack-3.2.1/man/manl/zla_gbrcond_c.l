.TH  ZLA_GBRCOND_C 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLA_GBRCOND_C - ZLA_GBRCOND_C Compute the infinity norm condition number of  op(A) * inv(diag(C)) where C is a DOUBLE PRECISION vector
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLA_GBRCOND_C( TRANS, N, KL, KU, AB,
LDAB, AFB, LDAFB, IPIV, C, CAPPLY,
INFO, WORK, RWORK )
.TP 17
.ti +4
IMPLICIT
NONE
.TP 17
.ti +4
CHARACTER
TRANS
.TP 17
.ti +4
LOGICAL
CAPPLY
.TP 17
.ti +4
INTEGER
N, KL, KU, KD, LDAB, LDAFB, INFO
.TP 17
.ti +4
INTEGER
IPIV( * )
.TP 17
.ti +4
COMPLEX*16
AB( LDAB, * ), AFB( LDAFB, * ), WORK( * )
.TP 17
.ti +4
DOUBLE
PRECISION C( * ), RWORK( * )
.SH PURPOSE
   ZLA_GBRCOND_C Computes the infinity norm condition number of
   op(A) * inv(diag(C)) where C is a DOUBLE PRECISION vector.
.SH ARGUMENTS
.TP 7
C      DOUBLE PRECISION vector.
.TP 7
WORK   COMPLEX*16 workspace of size 2*N.
.TP 7
RWORK  DOUBLE PRECISION workspace of size 3*N.
