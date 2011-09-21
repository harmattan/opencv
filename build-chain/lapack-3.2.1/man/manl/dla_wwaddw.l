.TH  DLA_WWADDW 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
DLA_WWADDW - DLA_WWADDW add a vector W into a doubled-single vector (X, Y)
.SH SYNOPSIS
.TP 23
SUBROUTINE DLA_WWADDW(
N, X, Y, W )
.TP 23
.ti +4
IMPLICIT
NONE
.TP 23
.ti +4
INTEGER
N
.TP 23
.ti +4
DOUBLE
PRECISION X( * ), Y( * ), W( * )
.SH PURPOSE
   DLA_WWADDW adds a vector W into a doubled-single vector (X, Y).
   This works for all extant IBM\(aqs hex and binary floating point
   arithmetics, but not for decimal.
.br
.SH ARGUMENTS
.TP 7
N      (input) INTEGER
The length of vectors X, Y, and W.
X, Y   (input/output) DOUBLE PRECISION array, length N
The doubled-single accumulation vector.
.TP 7
W      (input) DOUBLE PRECISION array, length N
The vector to be added.
