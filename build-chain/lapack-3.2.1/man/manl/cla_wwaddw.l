.TH  CLA_WWADDW 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_WWADDW - CLA_WWADDW add a vector W into a doubled-single vector (X, Y)
.SH SYNOPSIS
.TP 23
SUBROUTINE CLA_WWADDW(
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
COMPLEX
X( * ), Y( * ), W( * )
.SH PURPOSE
   CLA_WWADDW adds a vector W into a doubled-single vector (X, Y).
   This works for all extant IBM\(aqs hex and binary floating point
   arithmetics, but not for decimal.
.br
.SH ARGUMENTS
.TP 7
N      (input) INTEGER
The length of vectors X, Y, and W.
X, Y   (input/output) COMPLEX array, length N
The doubled-single accumulation vector.
.TP 7
W      (input) COMPLEX array, length N
The vector to be added.
