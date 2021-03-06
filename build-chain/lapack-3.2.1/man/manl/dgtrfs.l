.TH  DGTRFS 1 "November 2008" " LAPACK routine (version 3.2) " " LAPACK routine (version 3.2) " 
.SH NAME
DGTRFS - improves the computed solution to a system of linear equations when the coefficient matrix is tridiagonal, and provides error bounds and backward error estimates for the solution
.SH SYNOPSIS
.TP 19
SUBROUTINE DGTRFS(
TRANS, N, NRHS, DL, D, DU, DLF, DF, DUF, DU2,
IPIV, B, LDB, X, LDX, FERR, BERR, WORK, IWORK,
INFO )
.TP 19
.ti +4
CHARACTER
TRANS
.TP 19
.ti +4
INTEGER
INFO, LDB, LDX, N, NRHS
.TP 19
.ti +4
INTEGER
IPIV( * ), IWORK( * )
.TP 19
.ti +4
DOUBLE
PRECISION B( LDB, * ), BERR( * ), D( * ), DF( * ),
DL( * ), DLF( * ), DU( * ), DU2( * ), DUF( * ),
FERR( * ), WORK( * ), X( LDX, * )
.SH PURPOSE
DGTRFS improves the computed solution to a system of linear
equations when the coefficient matrix is tridiagonal, and provides
error bounds and backward error estimates for the solution.
.SH ARGUMENTS
.TP 8
TRANS   (input) CHARACTER*1
Specifies the form of the system of equations:
.br
= \(aqN\(aq:  A * X = B     (No transpose)
.br
= \(aqT\(aq:  A**T * X = B  (Transpose)
.br
= \(aqC\(aq:  A**H * X = B  (Conjugate transpose = Transpose)
.TP 8
N       (input) INTEGER
The order of the matrix A.  N >= 0.
.TP 8
NRHS    (input) INTEGER
The number of right hand sides, i.e., the number of columns
of the matrix B.  NRHS >= 0.
.TP 8
DL      (input) DOUBLE PRECISION array, dimension (N-1)
The (n-1) subdiagonal elements of A.
.TP 8
D       (input) DOUBLE PRECISION array, dimension (N)
The diagonal elements of A.
.TP 8
DU      (input) DOUBLE PRECISION array, dimension (N-1)
The (n-1) superdiagonal elements of A.
.TP 8
DLF     (input) DOUBLE PRECISION array, dimension (N-1)
The (n-1) multipliers that define the matrix L from the
LU factorization of A as computed by DGTTRF.
.TP 8
DF      (input) DOUBLE PRECISION array, dimension (N)
The n diagonal elements of the upper triangular matrix U from
the LU factorization of A.
.TP 8
DUF     (input) DOUBLE PRECISION array, dimension (N-1)
The (n-1) elements of the first superdiagonal of U.
.TP 8
DU2     (input) DOUBLE PRECISION array, dimension (N-2)
The (n-2) elements of the second superdiagonal of U.
.TP 8
IPIV    (input) INTEGER array, dimension (N)
The pivot indices; for 1 <= i <= n, row i of the matrix was
interchanged with row IPIV(i).  IPIV(i) will always be either
i or i+1; IPIV(i) = i indicates a row interchange was not
required.
.TP 8
B       (input) DOUBLE PRECISION array, dimension (LDB,NRHS)
The right hand side matrix B.
.TP 8
LDB     (input) INTEGER
The leading dimension of the array B.  LDB >= max(1,N).
.TP 8
X       (input/output) DOUBLE PRECISION array, dimension (LDX,NRHS)
On entry, the solution matrix X, as computed by DGTTRS.
On exit, the improved solution matrix X.
.TP 8
LDX     (input) INTEGER
The leading dimension of the array X.  LDX >= max(1,N).
.TP 8
FERR    (output) DOUBLE PRECISION array, dimension (NRHS)
The estimated forward error bound for each solution vector
X(j) (the j-th column of the solution matrix X).
If XTRUE is the true solution corresponding to X(j), FERR(j)
is an estimated upper bound for the magnitude of the largest
element in (X(j) - XTRUE) divided by the magnitude of the
largest element in X(j).  The estimate is as reliable as
the estimate for RCOND, and is almost always a slight
overestimate of the true error.
.TP 8
BERR    (output) DOUBLE PRECISION array, dimension (NRHS)
The componentwise relative backward error of each solution
vector X(j) (i.e., the smallest relative change in
any element of A or B that makes X(j) an exact solution).
.TP 8
WORK    (workspace) DOUBLE PRECISION array, dimension (3*N)
.TP 8
IWORK   (workspace) INTEGER array, dimension (N)
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
.SH PARAMETERS
ITMAX is the maximum number of steps of iterative refinement.
