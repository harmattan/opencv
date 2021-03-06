.TH  SGTTRS 1 "November 2008" " LAPACK routine (version 3.2) " " LAPACK routine (version 3.2) " 
.SH NAME
SGTTRS - solves one of the systems of equations  A*X = B or A\(aq*X = B,
.SH SYNOPSIS
.TP 19
SUBROUTINE SGTTRS(
TRANS, N, NRHS, DL, D, DU, DU2, IPIV, B, LDB,
INFO )
.TP 19
.ti +4
CHARACTER
TRANS
.TP 19
.ti +4
INTEGER
INFO, LDB, N, NRHS
.TP 19
.ti +4
INTEGER
IPIV( * )
.TP 19
.ti +4
REAL
B( LDB, * ), D( * ), DL( * ), DU( * ), DU2( * )
.SH PURPOSE
SGTTRS solves one of the systems of equations
   A*X = B  or  A\(aq*X = B,
with a tridiagonal matrix A using the LU factorization computed
by SGTTRF.
.br
.SH ARGUMENTS
.TP 8
TRANS   (input) CHARACTER*1
Specifies the form of the system of equations.
= \(aqN\(aq:  A * X = B  (No transpose)
.br
= \(aqT\(aq:  A\(aq* X = B  (Transpose)
.br
= \(aqC\(aq:  A\(aq* X = B  (Conjugate transpose = Transpose)
.TP 8
N       (input) INTEGER
The order of the matrix A.
.TP 8
NRHS    (input) INTEGER
The number of right hand sides, i.e., the number of columns
of the matrix B.  NRHS >= 0.
.TP 8
DL      (input) REAL array, dimension (N-1)
The (n-1) multipliers that define the matrix L from the
LU factorization of A.
.TP 8
D       (input) REAL array, dimension (N)
The n diagonal elements of the upper triangular matrix U from
the LU factorization of A.
.TP 8
DU      (input) REAL array, dimension (N-1)
The (n-1) elements of the first super-diagonal of U.
.TP 8
DU2     (input) REAL array, dimension (N-2)
The (n-2) elements of the second super-diagonal of U.
.TP 8
IPIV    (input) INTEGER array, dimension (N)
The pivot indices; for 1 <= i <= n, row i of the matrix was
interchanged with row IPIV(i).  IPIV(i) will always be either
i or i+1; IPIV(i) = i indicates a row interchange was not
required.
.TP 8
B       (input/output) REAL array, dimension (LDB,NRHS)
On entry, the matrix of right hand side vectors B.
On exit, B is overwritten by the solution vectors X.
.TP 8
LDB     (input) INTEGER
The leading dimension of the array B.  LDB >= max(1,N).
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
