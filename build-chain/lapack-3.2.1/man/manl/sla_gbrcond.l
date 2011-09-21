.TH  SLA_GBRCOND 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
SLA_GBRCOND - SLA_GERCOND Estimate the Skeel condition number of op(A) * op2(C)  where op2 is determined by CMODE as follows  CMODE = 1 op2(C) = C  CMODE = 0 op2(C) = I  CMODE = -1 op2(C) = inv(C)  The Skeel condition number cond(A) = norminf( |inv(A)||A| )  is computed by computing scaling factors R such that  diag(R)*A*op2(C) is row equilibrated and computing the standard  infinity-norm condition number
.SH SYNOPSIS
.TP 14
REAL FUNCTION
SLA_GBRCOND( TRANS, N, KL, KU, AB, LDAB, AFB, LDAFB,
IPIV, CMODE, C, INFO, WORK, IWORK )
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
N, LDAB, LDAFB, INFO, KL, KU, CMODE
.TP 14
.ti +4
INTEGER
IWORK( * ), IPIV( * )
.TP 14
.ti +4
REAL
AB( LDAB, * ), AFB( LDAFB, * ), WORK( * ),
C( * )
.SH PURPOSE
   SLA_GERCOND Estimates the Skeel condition number of  op(A) * op2(C)
   where op2 is determined by CMODE as follows
   CMODE =  1    op2(C) = C
   CMODE =  0    op2(C) = I
   CMODE = -1    op2(C) = inv(C)
   The Skeel condition number  cond(A) = norminf( |inv(A)||A| )
   is computed by computing scaling factors R such that
   diag(R)*A*op2(C) is row equilibrated and computing the standard
   infinity-norm condition number.
.SH ARGUMENTS
.TP 9
WORK     real workspace of size 5*N.
.TP 9
IWORK    integer workspace of size N.
