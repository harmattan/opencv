.TH  DPOSVXX 1 "November 2008" "    LAPACK driver routine (version 3.2)                          " "    LAPACK driver routine (version 3.2)                          " 
.SH NAME
DPOSVXX - DPOSVXX use the Cholesky factorization A = U**T*U or A = L*L**T  to compute the solution to a double precision system of linear equations  A * X = B, where A is an N-by-N symmetric positive definite matrix  and X and B are N-by-NRHS matrices
.SH SYNOPSIS
.TP 20
SUBROUTINE DPOSVXX(
FACT, UPLO, N, NRHS, A, LDA, AF, LDAF, EQUED,
S, B, LDB, X, LDX, RCOND, RPVGRW, BERR,
N_ERR_BNDS, ERR_BNDS_NORM, ERR_BNDS_COMP,
NPARAMS, PARAMS, WORK, IWORK, INFO )
.TP 20
.ti +4
IMPLICIT
NONE
.TP 20
.ti +4
CHARACTER
EQUED, FACT, UPLO
.TP 20
.ti +4
INTEGER
INFO, LDA, LDAF, LDB, LDX, N, NRHS, NPARAMS,
N_ERR_BNDS
.TP 20
.ti +4
DOUBLE
PRECISION RCOND, RPVGRW
.TP 20
.ti +4
INTEGER
IWORK( * )
.TP 20
.ti +4
DOUBLE
PRECISION A( LDA, * ), AF( LDAF, * ), B( LDB, * ),
X( LDX, * ), WORK( * )
.TP 20
.ti +4
DOUBLE
PRECISION S( * ), PARAMS( * ), BERR( * ),
ERR_BNDS_NORM( NRHS, * ),
ERR_BNDS_COMP( NRHS, * )
.SH PURPOSE
   DPOSVXX uses the Cholesky factorization A = U**T*U or A = L*L**T
   to compute the solution to a double precision system of linear equations
   A * X = B, where A is an N-by-N symmetric positive definite matrix
   and X and B are N-by-NRHS matrices.
   If requested, both normwise and maximum componentwise error bounds
   are returned. DPOSVXX will return a solution with a tiny
   guaranteed error (O(eps) where eps is the working machine
   precision) unless the matrix is very ill-conditioned, in which
   case a warning is returned. Relevant condition numbers also are
   calculated and returned.
.br
   DPOSVXX accepts user-provided factorizations and equilibration
   factors; see the definitions of the FACT and EQUED options.
   Solving with refinement and using a factorization from a previous
   DPOSVXX call will also produce a solution with either O(eps)
   errors or warnings, but we cannot make that claim for general
   user-provided factorizations and equilibration factors if they
   differ from what DPOSVXX would itself produce.
.br
.SH DESCRIPTION
   The following steps are performed:
.br
   1. If FACT = \(aqE\(aq, double precision scaling factors are computed to equilibrate
   the system:
.br
     diag(S)*A*diag(S)     *inv(diag(S))*X = diag(S)*B
.br
   Whether or not the system will be equilibrated depends on the
   scaling of the matrix A, but if equilibration is used, A is
   overwritten by diag(S)*A*diag(S) and B by diag(S)*B.
.br
   2. If FACT = \(aqN\(aq or \(aqE\(aq, the Cholesky decomposition is used to
   factor the matrix A (after equilibration if FACT = \(aqE\(aq) as
      A = U**T* U,  if UPLO = \(aqU\(aq, or
.br
      A = L * L**T,  if UPLO = \(aqL\(aq,
.br
   where U is an upper triangular matrix and L is a lower triangular
   matrix.
.br
   3. If the leading i-by-i principal minor is not positive definite,
   then the routine returns with INFO = i. Otherwise, the factored
   form of A is used to estimate the condition number of the matrix
   A (see argument RCOND).  If the reciprocal of the condition number
   is less than machine precision, the routine still goes on to solve
   for X and compute error bounds as described below.
.br
   4. The system of equations is solved for X using the factored form
   of A.
.br
   5. By default (unless PARAMS(LA_LINRX_ITREF_I) is set to zero),
   the routine will use iterative refinement to try to get a small
   error and error bounds.  Refinement calculates the residual to at
   least twice the working precision.
.br
   6. If equilibration was used, the matrix X is premultiplied by
   diag(S) so that it solves the original system before
.br
   equilibration.
.br
.SH ARGUMENTS
Some optional parameters are bundled in the PARAMS array.  These
settings determine how refinement is performed, but often the
defaults are acceptable.  If the defaults are acceptable, users
can pass NPARAMS = 0 which prevents the source code from accessing
the PARAMS argument.
.TP 8
FACT    (input) CHARACTER*1
Specifies whether or not the factored form of the matrix A is
supplied on entry, and if not, whether the matrix A should be
equilibrated before it is factored.
= \(aqF\(aq:  On entry, AF contains the factored form of A.
If EQUED is not \(aqN\(aq, the matrix A has been
equilibrated with scaling factors given by S.
A and AF are not modified.
= \(aqN\(aq:  The matrix A will be copied to AF and factored.
.br
= \(aqE\(aq:  The matrix A will be equilibrated if necessary, then
copied to AF and factored.
.TP 8
UPLO    (input) CHARACTER*1
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
of the matrices B and X.  NRHS >= 0.
.TP 8
A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)
On entry, the symmetric matrix A, except if FACT = \(aqF\(aq and EQUED =
\(aqY\(aq, then A must contain the equilibrated matrix
diag(S)*A*diag(S).  If UPLO = \(aqU\(aq, the leading N-by-N upper
triangular part of A contains the upper triangular part of the
matrix A, and the strictly lower triangular part of A is not
referenced.  If UPLO = \(aqL\(aq, the leading N-by-N lower triangular
part of A contains the lower triangular part of the matrix A, and
the strictly upper triangular part of A is not referenced.  A is
not modified if FACT = \(aqF\(aq or \(aqN\(aq, or if FACT = \(aqE\(aq and EQUED =
\(aqN\(aq on exit.
On exit, if FACT = \(aqE\(aq and EQUED = \(aqY\(aq, A is overwritten by
diag(S)*A*diag(S).
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,N).
.TP 8
AF      (input or output) DOUBLE PRECISION array, dimension (LDAF,N)
If FACT = \(aqF\(aq, then AF is an input argument and on entry
contains the triangular factor U or L from the Cholesky
factorization A = U**T*U or A = L*L**T, in the same storage
format as A.  If EQUED .ne. \(aqN\(aq, then AF is the factored
form of the equilibrated matrix diag(S)*A*diag(S).
If FACT = \(aqN\(aq, then AF is an output argument and on exit
returns the triangular factor U or L from the Cholesky
factorization A = U**T*U or A = L*L**T of the original
matrix A.
If FACT = \(aqE\(aq, then AF is an output argument and on exit
returns the triangular factor U or L from the Cholesky
factorization A = U**T*U or A = L*L**T of the equilibrated
matrix A (see the description of A for the form of the
equilibrated matrix).
.TP 8
LDAF    (input) INTEGER
The leading dimension of the array AF.  LDAF >= max(1,N).
.TP 8
EQUED   (input or output) CHARACTER*1
Specifies the form of equilibration that was done.
= \(aqN\(aq:  No equilibration (always true if FACT = \(aqN\(aq).
.br
= \(aqY\(aq:  Both row and column equilibration, i.e., A has been
replaced by diag(S) * A * diag(S).
EQUED is an input argument if FACT = \(aqF\(aq; otherwise, it is an
output argument.
.TP 8
S       (input or output) DOUBLE PRECISION array, dimension (N)
The row scale factors for A.  If EQUED = \(aqY\(aq, A is multiplied on
the left and right by diag(S).  S is an input argument if FACT =
\(aqF\(aq; otherwise, S is an output argument.  If FACT = \(aqF\(aq and EQUED
= \(aqY\(aq, each element of S must be positive.  If S is output, each
element of S is a power of the radix. If S is input, each element
of S should be a power of the radix to ensure a reliable solution
and error estimates. Scaling by powers of the radix does not cause
rounding errors unless the result underflows or overflows.
Rounding errors during scaling lead to refining with a matrix that
is not equivalent to the input matrix, producing error estimates
that may not be reliable.
.TP 8
B       (input/output) DOUBLE PRECISION array, dimension (LDB,NRHS)
On entry, the N-by-NRHS right hand side matrix B.
On exit,
if EQUED = \(aqN\(aq, B is not modified;
if EQUED = \(aqY\(aq, B is overwritten by diag(S)*B;
.TP 8
LDB     (input) INTEGER
The leading dimension of the array B.  LDB >= max(1,N).
.TP 8
X       (output) DOUBLE PRECISION array, dimension (LDX,NRHS)
If INFO = 0, the N-by-NRHS solution matrix X to the original
system of equations.  Note that A and B are modified on exit if
EQUED .ne. \(aqN\(aq, and the solution to the equilibrated system is
inv(diag(S))*X.
.TP 8
LDX     (input) INTEGER
The leading dimension of the array X.  LDX >= max(1,N).
.TP 8
RCOND   (output) DOUBLE PRECISION
Reciprocal scaled condition number.  This is an estimate of the
reciprocal Skeel condition number of the matrix A after
equilibration (if done).  If this is less than the machine
precision (in particular, if it is zero), the matrix is singular
to working precision.  Note that the error may still be small even
if this number is very small and the matrix appears ill-
conditioned.
.TP 8
RPVGRW  (output) DOUBLE PRECISION
Reciprocal pivot growth.  On exit, this contains the reciprocal
pivot growth factor norm(A)/norm(U). The "max absolute element"
norm is used.  If this is much less than 1, then the stability of
the LU factorization of the (equilibrated) matrix A could be poor.
This also means that the solution X, estimated condition numbers,
and error bounds could be unreliable. If factorization fails with
0<INFO<=N, then this contains the reciprocal pivot growth factor
for the leading INFO columns of A.
.TP 8
BERR    (output) DOUBLE PRECISION array, dimension (NRHS)
Componentwise relative backward error.  This is the
componentwise relative backward error of each solution vector X(j)
(i.e., the smallest relative change in any element of A or B that
makes X(j) an exact solution).
N_ERR_BNDS (input) INTEGER
Number of error bounds to return for each right hand side
and each type (normwise or componentwise).  See ERR_BNDS_NORM and
ERR_BNDS_COMP below.
.TP 15
ERR_BNDS_NORM  (output) DOUBLE PRECISION array, dimension (NRHS, N_ERR_BNDS)
For each right-hand side, this array contains information about
various error bounds and condition numbers corresponding to the
normwise relative error, which is defined as follows:
Normwise relative error in the ith solution vector:
max_j (abs(XTRUE(j,i) - X(j,i)))
------------------------------
max_j abs(X(j,i))
The array is indexed by the type of error information as described
below. There currently are up to three pieces of information
returned.
The first index in ERR_BNDS_NORM(i,:) corresponds to the ith
right-hand side.
The second index in ERR_BNDS_NORM(:,err) contains the following
three fields:
err = 1 "Trust/don\(aqt trust" boolean. Trust the answer if the
reciprocal condition number is less than the threshold
sqrt(n) * dlamch(\(aqEpsilon\(aq).
err = 2 "Guaranteed" error bound: The estimated forward error,
almost certainly within a factor of 10 of the true error
so long as the next entry is greater than the threshold
sqrt(n) * dlamch(\(aqEpsilon\(aq). This error bound should only
be trusted if the previous boolean is true.
err = 3  Reciprocal condition number: Estimated normwise
reciprocal condition number.  Compared with the threshold
sqrt(n) * dlamch(\(aqEpsilon\(aq) to determine if the error
estimate is "guaranteed". These reciprocal condition
numbers are 1 / (norm(Z^{-1},inf) * norm(Z,inf)) for some
appropriately scaled matrix Z.
Let Z = S*A, where S scales each row by a power of the
radix so all absolute row sums of Z are approximately 1.
See Lapack Working Note 165 for further details and extra
cautions.
.TP 15
ERR_BNDS_COMP  (output) DOUBLE PRECISION array, dimension (NRHS, N_ERR_BNDS)
For each right-hand side, this array contains information about
various error bounds and condition numbers corresponding to the
componentwise relative error, which is defined as follows:
Componentwise relative error in the ith solution vector:
abs(XTRUE(j,i) - X(j,i))
max_j ----------------------
abs(X(j,i))
The array is indexed by the right-hand side i (on which the
componentwise relative error depends), and the type of error
information as described below. There currently are up to three
pieces of information returned for each right-hand side. If
componentwise accuracy is not requested (PARAMS(3) = 0.0), then
ERR_BNDS_COMP is not accessed.  If N_ERR_BNDS .LT. 3, then at most
the first (:,N_ERR_BNDS) entries are returned.
The first index in ERR_BNDS_COMP(i,:) corresponds to the ith
right-hand side.
The second index in ERR_BNDS_COMP(:,err) contains the following
three fields:
err = 1 "Trust/don\(aqt trust" boolean. Trust the answer if the
reciprocal condition number is less than the threshold
sqrt(n) * dlamch(\(aqEpsilon\(aq).
err = 2 "Guaranteed" error bound: The estimated forward error,
almost certainly within a factor of 10 of the true error
so long as the next entry is greater than the threshold
sqrt(n) * dlamch(\(aqEpsilon\(aq). This error bound should only
be trusted if the previous boolean is true.
err = 3  Reciprocal condition number: Estimated componentwise
reciprocal condition number.  Compared with the threshold
sqrt(n) * dlamch(\(aqEpsilon\(aq) to determine if the error
estimate is "guaranteed". These reciprocal condition
numbers are 1 / (norm(Z^{-1},inf) * norm(Z,inf)) for some
appropriately scaled matrix Z.
Let Z = S*(A*diag(x)), where x is the solution for the
current right-hand side and S scales each row of
A*diag(x) by a power of the radix so all absolute row
sums of Z are approximately 1.
See Lapack Working Note 165 for further details and extra
cautions.
NPARAMS (input) INTEGER
Specifies the number of parameters set in PARAMS.  If .LE. 0, the
PARAMS array is never referenced and default values are used.
.TP 8
PARAMS  (input / output) DOUBLE PRECISION array, dimension NPARAMS
Specifies algorithm parameters.  If an entry is .LT. 0.0, then
that entry will be filled with default value used for that
parameter.  Only positions up to NPARAMS are accessed; defaults
are used for higher-numbered parameters.
PARAMS(LA_LINRX_ITREF_I = 1) : Whether to perform iterative
refinement or not.
Default: 1.0D+0
.br
= 0.0 : No refinement is performed, and no error bounds are
computed.
= 1.0 : Use the extra-precise refinement algorithm.
(other values are reserved for future use)
PARAMS(LA_LINRX_ITHRESH_I = 2) : Maximum number of residual
computations allowed for refinement.
Default: 10
.br
Aggressive: Set to 100 to permit convergence using approximate
factorizations or factorizations other than LU. If
the factorization uses a technique other than
Gaussian elimination, the guarantees in
err_bnds_norm and err_bnds_comp may no longer be
trustworthy.
PARAMS(LA_LINRX_CWISE_I = 3) : Flag determining if the code
will attempt to find a solution with small componentwise
relative error in the double-precision algorithm.  Positive
is true, 0.0 is false.
Default: 1.0 (attempt componentwise convergence)
.TP 8
WORK    (workspace) DOUBLE PRECISION array, dimension (4*N)
.TP 8
IWORK   (workspace) INTEGER array, dimension (N)
.TP 8
INFO    (output) INTEGER
.br
= 0:  Successful exit. The solution to every right-hand side is
guaranteed.
< 0:  If INFO = -i, the i-th argument had an illegal value
.br
> 0 and <= N:  U(INFO,INFO) is exactly zero.  The factorization
has been completed, but the factor U is exactly singular, so
the solution and error bounds could not be computed. RCOND = 0
is returned.
= N+J: The solution corresponding to the Jth right-hand side is
not guaranteed. The solutions corresponding to other right-
hand sides K with K > J may not be guaranteed as well, but
only the first such right-hand side is reported. If a small
componentwise error is not requested (PARAMS(3) = 0.0) then
the Jth right-hand side is the first with a normwise error
bound that is not guaranteed (the smallest J such
that ERR_BNDS_NORM(J,1) = 0.0). By default (PARAMS(3) = 1.0)
the Jth right-hand side is the first with either a normwise or
componentwise error bound that is not guaranteed (the smallest
J such that either ERR_BNDS_NORM(J,1) = 0.0 or
ERR_BNDS_COMP(J,1) = 0.0). See the definition of
ERR_BNDS_NORM(:,1) and ERR_BNDS_COMP(:,1). To get information
about all of the right-hand sides check ERR_BNDS_NORM or
ERR_BNDS_COMP.
