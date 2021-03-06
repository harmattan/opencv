.TH CGBMV l "16 October 1992" "BLAS routine" "BLAS routine"
.SH NAME
CGBMV - perform one of the matrix-vector operations   y := alpha*A*x + beta*y, or y := alpha*A'*x + beta*y, or   y := alpha*conjg( A' )*x + beta*y,
.SH SYNOPSIS
.TP 17
SUBROUTINE CGBMV
( TRANS, M, N, KL, KU, ALPHA, A, LDA, X, INCX,
BETA, Y, INCY )
.TP 17
.ti +4
COMPLEX
ALPHA, BETA
.TP 17
.ti +4
INTEGER
INCX, INCY, KL, KU, LDA, M, N
.TP 17
.ti +4
CHARACTER*1
TRANS
.TP 17
.ti +4
COMPLEX
A( LDA, * ), X( * ), Y( * )
.SH PURPOSE
CGBMV  performs one of the matrix-vector operations

where alpha and beta are scalars, x and y are vectors and A is an
m by n band matrix, with kl sub-diagonals and ku super-diagonals.

.SH PARAMETERS
.TP 7
TRANS  - CHARACTER*1.
On entry, TRANS specifies the operation to be performed as
follows:

TRANS = 'N' or 'n'   y := alpha*A*x + beta*y.

TRANS = 'T' or 't'   y := alpha*A'*x + beta*y.

TRANS = 'C' or 'c'   y := alpha*conjg( A' )*x + beta*y.

Unchanged on exit.
.TP 7
M      - INTEGER.
On entry, M specifies the number of rows of the matrix A.
M must be at least zero.
Unchanged on exit.
.TP 7
N      - INTEGER.
On entry, N specifies the number of columns of the matrix A.
N must be at least zero.
Unchanged on exit.
.TP 7
KL     - INTEGER.
On entry, KL specifies the number of sub-diagonals of the
matrix A. KL must satisfy  0 .le. KL.
Unchanged on exit.
.TP 7
KU     - INTEGER.
On entry, KU specifies the number of super-diagonals of the
matrix A. KU must satisfy  0 .le. KU.
Unchanged on exit.
.TP 7
ALPHA  - COMPLEX         .
On entry, ALPHA specifies the scalar alpha.
Unchanged on exit.
.TP 7
A      - COMPLEX          array of DIMENSION ( LDA, n ).
Before entry, the leading ( kl + ku + 1 ) by n part of the
array A must contain the matrix of coefficients, supplied
column by column, with the leading diagonal of the matrix in
row ( ku + 1 ) of the array, the first super-diagonal
starting at position 2 in row ku, the first sub-diagonal
starting at position 1 in row ( ku + 2 ), and so on.
Elements in the array A that do not correspond to elements
in the band matrix (such as the top left ku by ku triangle)
are not referenced.
The following program segment will transfer a band matrix
from conventional full matrix storage to band storage:

DO 20, J = 1, N
K = KU + 1 - J
DO 10, I = MAX( 1, J - KU ), MIN( M, J + KL )
A( K + I, J ) = matrix( I, J )
10    CONTINUE
20 CONTINUE

Unchanged on exit.
.TP 7
LDA    - INTEGER.
On entry, LDA specifies the first dimension of A as declared
in the calling (sub) program. LDA must be at least
( kl + ku + 1 ).
Unchanged on exit.
.TP 7
X      - COMPLEX          array of DIMENSION at least
( 1 + ( n - 1 )*abs( INCX ) ) when TRANS = 'N' or 'n'
and at least
( 1 + ( m - 1 )*abs( INCX ) ) otherwise.
Before entry, the incremented array X must contain the
vector x.
Unchanged on exit.
.TP 7
INCX   - INTEGER.
On entry, INCX specifies the increment for the elements of
X. INCX must not be zero.
Unchanged on exit.
.TP 7
BETA   - COMPLEX         .
On entry, BETA specifies the scalar beta. When BETA is
supplied as zero then Y need not be set on input.
Unchanged on exit.
.TP 7
Y      - COMPLEX          array of DIMENSION at least
( 1 + ( m - 1 )*abs( INCY ) ) when TRANS = 'N' or 'n'
and at least
( 1 + ( n - 1 )*abs( INCY ) ) otherwise.
Before entry, the incremented array Y must contain the
vector y. On exit, Y is overwritten by the updated vector y.
.TP 7
INCY   - INTEGER.
On entry, INCY specifies the increment for the elements of
Y. INCY must not be zero.
Unchanged on exit.

Level 2 Blas routine.

-- Written on 22-October-1986.
Jack Dongarra, Argonne National Lab.
Jeremy Du Croz, Nag Central Office.
Sven Hammarling, Nag Central Office.
Richard Hanson, Sandia National Labs.
