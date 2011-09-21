.TH  CLA_GBRCOND_C 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_GBRCOND_C - CLA_GBRCOND_C Compute the infinity norm condition number of  op(A) * inv(diag(C)) where C is a REAL vector
.SH SYNOPSIS
.TP 14
REAL FUNCTION
CLA_GBRCOND_C( TRANS, N, KL, KU, AB, LDAB, AFB,
LDAFB, IPIV, C, CAPPLY, INFO, WORK,
RWORK )
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
LOGICAL
CAPPLY
.TP 14
.ti +4
INTEGER
N, KL, KU, KD, LDAB, LDAFB, INFO
.TP 14
.ti +4
INTEGER
IPIV( * )
.TP 14
.ti +4
COMPLEX
AB( LDAB, * ), AFB( LDAFB, * ), WORK( * )
.TP 14
.ti +4
REAL
C( * ), RWORK( * )
.SH PURPOSE
   CLA_GBRCOND_C Computes the infinity norm condition number of
   op(A) * inv(diag(C)) where C is a REAL vector.
.SH ARGUMENTS
.TP 8
C       REAL vector.
.TP 8
WORK    COMPLEX workspace of size 2*N.
.TP 8
RWORK   REAL workspace of size 3*N.
