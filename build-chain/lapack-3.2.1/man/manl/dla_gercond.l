.TH  DLA_GERCOND 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
DLA_GERCOND - DLA_GERCOND estimate the Skeel condition number of op(A) * op2(C)  where op2 is determined by CMODE as follows  CMODE = 1 op2(C) = C  CMODE = 0 op2(C) = I  CMODE = -1 op2(C) = inv(C)  The Skeel condition number cond(A) = norminf( |inv(A)||A| )  is computed by computing scaling factors R such that  diag(R)*A*op2(C) is row equilibrated and computing the standard  infinity-norm condition number
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION DLA_GERCOND ( TRANS, N, A, LDA, AF,
LDAF, IPIV, CMODE, C, INFO, WORK,
IWORK )
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
N, LDA, LDAF, INFO, CMODE
.TP 17
.ti +4
INTEGER
IPIV( * ), IWORK( * )
.TP 17
.ti +4
DOUBLE
PRECISION A( LDA, * ), AF( LDAF, * ), WORK( * ),
C( * )
.SH PURPOSE
   DLA_GERCOND estimates the Skeel condition number of op(A) * op2(C)
   where op2 is determined by CMODE as follows
   CMODE =  1    op2(C) = C
   CMODE =  0    op2(C) = I
   CMODE = -1    op2(C) = inv(C)
   The Skeel condition number cond(A) = norminf( |inv(A)||A| )
   is computed by computing scaling factors R such that
   diag(R)*A*op2(C) is row equilibrated and computing the standard
   infinity-norm condition number.
.SH ARGUMENTS
.TP 8
WORK    DOUBLE PRECISION workspace of size 3*N, and
.TP 8
IWORK   INTEGER workspace of size N.
