.TH  ZLASCL2 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
ZLASCL2 - performs a diagonal scaling on a vector
.SH SYNOPSIS
.TP 19
SUBROUTINE ZLASCL2
( M, N, D, X, LDX )
.TP 19
.ti +4
IMPLICIT
NONE
.TP 19
.ti +4
INTEGER
M, N, LDX
.TP 19
.ti +4
DOUBLE
PRECISION D( * )
.TP 19
.ti +4
COMPLEX*16
X( LDX, * )
.SH PURPOSE
ZLASCL2 performs a diagonal scaling on a vector:
  x <-- D * x
.br
where the diagonal matrix D is stored as a vector.
.br
Eventually to be replaced by BLAS_sge_diag_scale in the new BLAS
standard.
.br
.SH ARGUMENTS
The size of the vectors X and D.
.TP 7
D      (input) DOUBLE PRECISION array, length N
Diagonal matrix D, stored as a vector of length N.
X      (input/output) COMPLEX*16 array, length N
On entry, the vector X to be scaled by D.
On exit, the scaled vector.
..
.. Local Scalars ..
..
.. Executable Statements ..
