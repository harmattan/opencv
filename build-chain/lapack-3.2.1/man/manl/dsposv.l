.TH  DSPOSV 1 "November 2008" " LAPACK PROTOTYPE driver routine (version 3.1.2) " " LAPACK PROTOTYPE driver routine (version 3.1.2) " 
.SH NAME
DSPOSV - computes the solution to a real system of linear equations  A * X = B,
.SH SYNOPSIS
.TP 19
SUBROUTINE DSPOSV(
UPLO, N, NRHS, A, LDA, B, LDB, X, LDX, WORK,
.TP 19
.ti +4
+
SWORK, ITER, INFO )
.TP 19
.ti +4
CHARACTER
UPLO
.TP 19
.ti +4
INTEGER
INFO, ITER, LDA, LDB, LDX, N, NRHS
.TP 19
.ti +4
REAL
SWORK( * )
.TP 19
.ti +4
DOUBLE
PRECISION A( LDA, * ), B( LDB, * ), WORK( N, * ),
.TP 19
.ti +4
+
X( LDX, * )
.SH PURPOSE
DSPOSV computes the solution to a real system of linear equations
   A * X = B,
where A is an N-by-N symmetric positive definite matrix and X and B
are N-by-NRHS matrices.
.br
DSPOSV first attempts to factorize the matrix in SINGLE PRECISION
and use this factorization within an iterative refinement procedure
to produce a solution with DOUBLE PRECISION normwise backward error
quality (see below). If the approach fails the method switches to a
DOUBLE PRECISION factorization and solve.
.br
The iterative refinement is not going to be a winning strategy if
the ratio SINGLE PRECISION performance over DOUBLE PRECISION
performance is too small. A reasonable strategy should take the
number of right-hand sides and the size of the matrix into account.
This might be done with a call to ILAENV in the future. Up to now, we
always try iterative refinement.
.br
The iterative refinement process is stopped if
.br
    ITER > ITERMAX
.br
or for all the RHS we have:
.br
    RNRM < SQRT(N)*XNRM*ANRM*EPS*BWDMAX
.br
where
.br
    o ITER is the number of the current iteration in the iterative
      refinement process
.br
    o RNRM is the infinity-norm of the residual
.br
    o XNRM is the infinity-norm of the solution
.br
    o ANRM is the infinity-operator-norm of the matrix A
.br
    o EPS is the machine epsilon returned by DLAMCH(\(aqEpsilon\(aq)
The value ITERMAX and BWDMAX are fixed to 30 and 1.0D+00
.br
respectively.
.br
.SH ARGUMENTS
.TP 8
UPLO    (input) CHARACTER
= \(aqU\(aq:  Upper triangle of A is stored;
.br
= \(aqL\(aq:  Lower triangle of A is stored.
.TP 8
N       (input) INTEGER
The number of linear equations, i.e., the order of the
matrix A.  N >= 0.
.TP 8
NRHS    (input) INTEGER
The number of right hand sides, i.e., the number of columns
of the matrix B.  NRHS >= 0.
.TP 8
A       (input or input/ouptut) DOUBLE PRECISION array,
dimension (LDA,N)
On entry, the symmetric matrix A.  If UPLO = \(aqU\(aq, the leading
N-by-N upper triangular part of A contains the upper
triangular part of the matrix A, and the strictly lower
triangular part of A is not referenced.  If UPLO = \(aqL\(aq, the
leading N-by-N lower triangular part of A contains the lower
triangular part of the matrix A, and the strictly upper
triangular part of A is not referenced.
On exit, if iterative refinement has been successfully used
(INFO.EQ.0 and ITER.GE.0, see description below), then A is
unchanged, if double precision factorization has been used
(INFO.EQ.0 and ITER.LT.0, see description below), then the
array A contains the factor U or L from the Cholesky
factorization A = U**T*U or A = L*L**T.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,N).
.TP 8
B       (input) DOUBLE PRECISION array, dimension (LDB,NRHS)
The N-by-NRHS right hand side matrix B.
.TP 8
LDB     (input) INTEGER
The leading dimension of the array B.  LDB >= max(1,N).
.TP 8
X       (output) DOUBLE PRECISION array, dimension (LDX,NRHS)
If INFO = 0, the N-by-NRHS solution matrix X.
.TP 8
LDX     (input) INTEGER
The leading dimension of the array X.  LDX >= max(1,N).
.TP 8
WORK    (workspace) DOUBLE PRECISION array, dimension (N*NRHS)
This array is used to hold the residual vectors.
.TP 8
SWORK   (workspace) REAL array, dimension (N*(N+NRHS))
This array is used to use the single precision matrix and the
right-hand sides or solutions in single precision.
.TP 8
ITER    (output) INTEGER
< 0: iterative refinement has failed, double precision
factorization has been performed
-1 : the routine fell back to full precision for
implementation- or machine-specific reasons
-2 : narrowing the precision induced an overflow,
the routine fell back to full precision
-3 : failure of SPOTRF
.br
-31: stop the iterative refinement after the 30th
iterations
> 0: iterative refinement has been sucessfully used.
Returns the number of iterations
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
.br
> 0:  if INFO = i, the leading minor of order i of (DOUBLE
PRECISION) A is not positive definite, so the
factorization could not be completed, and the solution
has not been computed.
=========
