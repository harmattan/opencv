.TH ZHER l "16 October 1992" "BLAS routine" "BLAS routine"
.SH NAME
ZHER - perform the hermitian rank 1 operation   A := alpha*x*conjg( x' ) + A,
.SH SYNOPSIS
.TP 16
SUBROUTINE ZHER
( UPLO, N, ALPHA, X, INCX, A, LDA )
.TP 16
.ti +4
DOUBLE
PRECISION ALPHA
.TP 16
.ti +4
INTEGER
INCX, LDA, N
.TP 16
.ti +4
CHARACTER*1
UPLO
.TP 16
.ti +4
COMPLEX*16
A( LDA, * ), X( * )
.SH PURPOSE
ZHER   performs the hermitian rank 1 operation

where alpha is a real scalar, x is an n element vector and A is an
n by n hermitian matrix.
.br

.SH PARAMETERS
.TP 7
UPLO   - CHARACTER*1.
On entry, UPLO specifies whether the upper or lower
triangular part of the array A is to be referenced as
follows:

UPLO = 'U' or 'u'   Only the upper triangular part of A
is to be referenced.

UPLO = 'L' or 'l'   Only the lower triangular part of A
is to be referenced.

Unchanged on exit.
.TP 7
N      - INTEGER.
On entry, N specifies the order of the matrix A.
N must be at least zero.
Unchanged on exit.
.TP 7
ALPHA  - DOUBLE PRECISION.
On entry, ALPHA specifies the scalar alpha.
Unchanged on exit.
.TP 7
X      - COMPLEX*16       array of dimension at least
( 1 + ( n - 1 )*abs( INCX ) ).
Before entry, the incremented array X must contain the n
element vector x.
Unchanged on exit.
.TP 7
INCX   - INTEGER.
On entry, INCX specifies the increment for the elements of
X. INCX must not be zero.
Unchanged on exit.
.TP 7
A      - COMPLEX*16       array of DIMENSION ( LDA, n ).
Before entry with  UPLO = 'U' or 'u', the leading n by n
upper triangular part of the array A must contain the upper
triangular part of the hermitian matrix and the strictly
lower triangular part of A is not referenced. On exit, the
upper triangular part of the array A is overwritten by the
upper triangular part of the updated matrix.
Before entry with UPLO = 'L' or 'l', the leading n by n
lower triangular part of the array A must contain the lower
triangular part of the hermitian matrix and the strictly
upper triangular part of A is not referenced. On exit, the
lower triangular part of the array A is overwritten by the
lower triangular part of the updated matrix.
Note that the imaginary parts of the diagonal elements need
not be set, they are assumed to be zero, and on exit they
are set to zero.
.TP 7
LDA    - INTEGER.
On entry, LDA specifies the first dimension of A as declared
in the calling (sub) program. LDA must be at least
max( 1, n ).
Unchanged on exit.

Level 2 Blas routine.

-- Written on 22-October-1986.
Jack Dongarra, Argonne National Lab.
Jeremy Du Croz, Nag Central Office.
Sven Hammarling, Nag Central Office.
Richard Hanson, Sandia National Labs.
