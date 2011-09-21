.TH  DLARSCL2 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
DLARSCL2 - performs a reciprocal diagonal scaling on an vector
.SH SYNOPSIS
.TP 20
SUBROUTINE DLARSCL2
( M, N, D, X, LDX )
.TP 20
.ti +4
IMPLICIT
NONE
.TP 20
.ti +4
INTEGER
M, N, LDX
.TP 20
.ti +4
DOUBLE
PRECISION D( * ), X( LDX, * )
.SH PURPOSE
DLARSCL2 performs a reciprocal diagonal scaling on an vector:
  x <-- inv(D) * x
.br
where the diagonal matrix D is stored as a vector.
.br
Eventually to be replaced by BLAS_sge_diag_scale in the new BLAS
standard.
.br
.SH ARGUMENTS
.TP 7
N      (input) INTEGER
The size of the vectors X and D.
.TP 7
D      (input) DOUBLE PRECISION array, length N
Diagonal matrix D, stored as a vector of length N.
.TP 7
X      (input/output) DOUBLE PRECISION array, length N
On entry, the vector X to be scaled by D.
On exit, the scaled vector.
..
.. Local Scalars ..
..
.. Executable Statements ..
