.TH  CLA_GBRCOND_X 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_GBRCOND_X - CLA_GBRCOND_X Compute the infinity norm condition number of  op(A) * diag(X) where X is a COMPLEX vector
.SH SYNOPSIS
.TP 14
REAL FUNCTION
CLA_GBRCOND_X( TRANS, N, KL, KU, AB, LDAB, AFB,
LDAFB, IPIV, X, INFO, WORK, RWORK )
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
N, KL, KU, KD, LDAB, LDAFB, INFO
.TP 14
.ti +4
INTEGER
IPIV( * )
.TP 14
.ti +4
COMPLEX
AB( LDAB, * ), AFB( LDAFB, * ), WORK( * ),
X( * )
.TP 14
.ti +4
REAL
RWORK( * )
.SH PURPOSE
   CLA_GBRCOND_X Computes the infinity norm condition number of
   op(A) * diag(X) where X is a COMPLEX vector.
.SH ARGUMENTS
.TP 8
X       COMPLEX vector.
.TP 8
WORK    COMPLEX workspace of size 2*N.
.TP 8
RWORK   REAL workspace of size 3*N.
