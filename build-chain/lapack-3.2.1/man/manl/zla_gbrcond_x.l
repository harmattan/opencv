.TH  ZLA_GBRCOND_X 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLA_GBRCOND_X - ZLA_GBRCOND_X Compute the infinity norm condition number of  op(A) * diag(X) where X is a COMPLEX*16 vector
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLA_GBRCOND_X( TRANS, N, KL, KU, AB,
LDAB, AFB, LDAFB, IPIV, X, INFO,
WORK, RWORK )
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
INTEGER
N, KL, KU, KD, LDAB, LDAFB, INFO
.TP 17
.ti +4
INTEGER
IPIV( * )
.TP 17
.ti +4
COMPLEX*16
AB( LDAB, * ), AFB( LDAFB, * ), WORK( * ),
X( * )
.TP 17
.ti +4
DOUBLE
PRECISION RWORK( * )
.SH PURPOSE
   ZLA_GBRCOND_X Computes the infinity norm condition number of
   op(A) * diag(X) where X is a COMPLEX*16 vector.
.SH ARGUMENTS
.TP 6
X     COMPLEX*16 vector.
.TP 6
WORK  COMPLEX*16 workspace of size 2*N.
RWORK DOUBLE PRECISION workspace of size 3*N.
