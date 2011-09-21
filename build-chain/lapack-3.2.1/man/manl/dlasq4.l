.TH  DLASQ4 1 "November 2008" " LAPACK routine (version 3.2)                                    " " LAPACK routine (version 3.2)                                    " 
.SH NAME
DLASQ4 - computes an approximation TAU to the smallest eigenvalue using values of d from the previous transform
.SH SYNOPSIS
.TP 19
SUBROUTINE DLASQ4(
I0, N0, Z, PP, N0IN, DMIN, DMIN1, DMIN2, DN,
DN1, DN2, TAU, TTYPE, G )
.TP 19
.ti +4
INTEGER
I0, N0, N0IN, PP, TTYPE
.TP 19
.ti +4
DOUBLE
PRECISION DMIN, DMIN1, DMIN2, DN, DN1, DN2, G, TAU
.TP 19
.ti +4
DOUBLE
PRECISION Z( * )
.SH PURPOSE
DLASQ4 computes an approximation TAU to the smallest eigenvalue
using values of d from the previous transform.
I0    (input) INTEGER
.br
      First index.
.br
N0    (input) INTEGER
.br
      Last index.
.br
Z     (input) DOUBLE PRECISION array, dimension ( 4*N )
.br
      Z holds the qd array.
.br
PP    (input) INTEGER
.br
      PP=0 for ping, PP=1 for pong.
.br
NOIN  (input) INTEGER
.br
      The value of N0 at start of EIGTEST.
.br
DMIN  (input) DOUBLE PRECISION
.br
      Minimum value of d.
.br
DMIN1 (input) DOUBLE PRECISION
.br
      Minimum value of d, excluding D( N0 ).
.br
DMIN2 (input) DOUBLE PRECISION
.br
      Minimum value of d, excluding D( N0 ) and D( N0-1 ).
DN    (input) DOUBLE PRECISION
.br
      d(N)
.br
DN1   (input) DOUBLE PRECISION
.br
      d(N-1)
.br
DN2   (input) DOUBLE PRECISION
.br
      d(N-2)
.br
TAU   (output) DOUBLE PRECISION
.br
      This is the shift.
.br
TTYPE (output) INTEGER
.br
      Shift type.
.br
G     (input/output) REAL
.br
      G is passed as an argument in order to save its value between
      calls to DLASQ4.
.br
.SH FURTHER DETAILS
