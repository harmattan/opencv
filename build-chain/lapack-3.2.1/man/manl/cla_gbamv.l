.TH  CLA_GBAMV 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
CLA_GBAMV - performs one of the matrix-vector operations   y := alpha*abs(A)*abs(x) + beta*abs(y),
.SH SYNOPSIS
.TP 22
SUBROUTINE CLA_GBAMV(
TRANS, M, N, KL, KU, ALPHA, AB, LDAB, X,
INCX, BETA, Y, INCY )
.TP 22
.ti +4
IMPLICIT
NONE
.TP 22
.ti +4
REAL
ALPHA, BETA
.TP 22
.ti +4
INTEGER
INCX, INCY, LDAB, M, N, KL, KU, TRANS
.TP 22
.ti +4
COMPLEX
AB( LDAB, * ), X( * )
.TP 22
.ti +4
REAL
Y( * )
.SH PURPOSE
SLA_GEAMV  performs one of the matrix-vector operations
   or   y := alpha*abs(A)\(aq*abs(x) + beta*abs(y),
.br
where alpha and beta are scalars, x and y are vectors and A is an
m by n matrix.
.br
This function is primarily used in calculating error bounds.
To protect against underflow during evaluation, components in
the resulting vector are perturbed away from zero by (N+1)
times the underflow threshold.  To prevent unnecessarily large
errors for block-structure embedded in general matrices,
.br
"symbolically" zero components are not perturbed.  A zero
entry is considered "symbolic" if all multiplications involved
in computing that entry have at least one zero multiplicand.
.SH ARGUMENTS
.TP 7
TRANS  - INTEGER
On entry, TRANS specifies the operation to be performed as
follows:
.TP 19
BLAS_NO_TRANS      y := alpha*abs(A)*abs(x) + beta*abs(y)
.br
BLAS_TRANS         y := alpha*abs(A\(aq)*abs(x) + beta*abs(y)
.br
BLAS_CONJ_TRANS    y := alpha*abs(A\(aq)*abs(x) + beta*abs(y)
Unchanged on exit.
.TP 7
M      - INTEGER
On entry, M specifies the number of rows of the matrix A.
M must be at least zero.
Unchanged on exit.
.TP 7
N      - INTEGER
On entry, N specifies the number of columns of the matrix A.
N must be at least zero.
Unchanged on exit.
.TP 7
KL     - INTEGER
The number of subdiagonals within the band of A.  KL >= 0.
.TP 7
KU     - INTEGER
The number of superdiagonals within the band of A.  KU >= 0.
.TP 7
ALPHA  - REAL
On entry, ALPHA specifies the scalar alpha.
Unchanged on exit.
.TP 7
A      - REAL             array of DIMENSION ( LDA, n )
Before entry, the leading m by n part of the array A must
contain the matrix of coefficients.
Unchanged on exit.
.TP 7
LDA    - INTEGER
On entry, LDA specifies the first dimension of A as declared
in the calling (sub) program. LDA must be at least
max( 1, m ).
Unchanged on exit.
.TP 7
X      - REAL             array of DIMENSION at least
( 1 + ( n - 1 )*abs( INCX ) ) when TRANS = \(aqN\(aq or \(aqn\(aq
and at least
( 1 + ( m - 1 )*abs( INCX ) ) otherwise.
Before entry, the incremented array X must contain the
vector x.
Unchanged on exit.
.TP 7
INCX   - INTEGER
On entry, INCX specifies the increment for the elements of
X. INCX must not be zero.
Unchanged on exit.
.TP 7
BETA   - REAL
On entry, BETA specifies the scalar beta. When BETA is
supplied as zero then Y need not be set on input.
Unchanged on exit.
.TP 7
Y      - REAL             array of DIMENSION at least
( 1 + ( m - 1 )*abs( INCY ) ) when TRANS = \(aqN\(aq or \(aqn\(aq
and at least
( 1 + ( n - 1 )*abs( INCY ) ) otherwise.
Before entry with BETA non-zero, the incremented array Y
must contain the vector y. On exit, Y is overwritten by the
updated vector y.
.TP 7
INCY   - INTEGER
On entry, INCY specifies the increment for the elements of
Y. INCY must not be zero.
Unchanged on exit.
Level 2 Blas routine.
