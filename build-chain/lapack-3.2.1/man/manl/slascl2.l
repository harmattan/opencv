.TH  SLASCL2 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
SLASCL2 - performs a diagonal scaling on a vector
.SH SYNOPSIS
.TP 19
SUBROUTINE SLASCL2
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
REAL
D( * ), X( LDX, * )
.SH PURPOSE
SLASCL2 performs a diagonal scaling on a vector:
  x <-- D * x
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
D      (input) REAL array, length N
Diagonal matrix D, stored as a vector of length N.
.TP 7
X      (input/output) REAL array, length N
On entry, the vector X to be scaled by D.
On exit, the scaled vector.
..
.. Local Scalars ..
..
.. Executable Statements ..
