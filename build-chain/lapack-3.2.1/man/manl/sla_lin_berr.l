.TH  SLA_LIN_BERR 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
SLA_LIN_BERR - SLA_LIN_BERR compute component-wise relative backward error from  the formula  max(i) ( abs(R(i)) / ( abs(op(A_s))*abs(Y) + abs(B_s) )(i) )  where abs(Z) is the component-wise absolute value of the matrix  or vector Z
.SH SYNOPSIS
.TP 24
SUBROUTINE SLA_LIN_BERR
( N, NZ, NRHS, RES, AYB, BERR )
.TP 24
.ti +4
IMPLICIT
NONE
.TP 24
.ti +4
INTEGER
N, NZ, NRHS
.TP 24
.ti +4
REAL
AYB( N, NRHS ), BERR( NRHS )
.TP 24
.ti +4
REAL
RES( N, NRHS )
.SH PURPOSE
   SLA_LIN_BERR computes component-wise relative backward error from
   the formula
       max(i) ( abs(R(i)) / ( abs(op(A_s))*abs(Y) + abs(B_s) )(i) )
   where abs(Z) is the component-wise absolute value of the matrix
   or vector Z.
