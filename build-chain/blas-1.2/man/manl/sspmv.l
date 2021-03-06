.TH SSPMV l "16 October 1992" "BLAS routine" "BLAS routine"
.SH NAME
SSPMV - perform the matrix-vector operation   y := alpha*A*x + beta*y,
.SH SYNOPSIS
.TP 17
SUBROUTINE SSPMV
( UPLO, N, ALPHA, AP, X, INCX, BETA, Y, INCY )
.TP 17
.ti +4
REAL
ALPHA, BETA
.TP 17
.ti +4
INTEGER
INCX, INCY, N
.TP 17
.ti +4
CHARACTER*1
UPLO
.TP 17
.ti +4
REAL
AP( * ), X( * ), Y( * )
.SH PURPOSE
SSPMV  performs the matrix-vector operation

where alpha and beta are scalars, x and y are n element vectors and
A is an n by n symmetric matrix, supplied in packed form.

.SH PARAMETERS
.TP 7
UPLO   - CHARACTER*1.
On entry, UPLO specifies whether the upper or lower
triangular part of the matrix A is supplied in the packed
array AP as follows:

UPLO = 'U' or 'u'   The upper triangular part of A is
supplied in AP.

UPLO = 'L' or 'l'   The lower triangular part of A is
supplied in AP.

Unchanged on exit.
.TP 7
N      - INTEGER.
On entry, N specifies the order of the matrix A.
N must be at least zero.
Unchanged on exit.
.TP 7
ALPHA  - REAL            .
On entry, ALPHA specifies the scalar alpha.
Unchanged on exit.
.TP 7
AP     - REAL             array of DIMENSION at least
( ( n*( n + 1 ) )/2 ).
Before entry with UPLO = 'U' or 'u', the array AP must
contain the upper triangular part of the symmetric matrix
packed sequentially, column by column, so that AP( 1 )
contains a( 1, 1 ), AP( 2 ) and AP( 3 ) contain a( 1, 2 )
and a( 2, 2 ) respectively, and so on.
Before entry with UPLO = 'L' or 'l', the array AP must
contain the lower triangular part of the symmetric matrix
packed sequentially, column by column, so that AP( 1 )
contains a( 1, 1 ), AP( 2 ) and AP( 3 ) contain a( 2, 1 )
and a( 3, 1 ) respectively, and so on.
Unchanged on exit.
.TP 7
X      - REAL             array of dimension at least
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
BETA   - REAL            .
On entry, BETA specifies the scalar beta. When BETA is
supplied as zero then Y need not be set on input.
Unchanged on exit.
.TP 7
Y      - REAL             array of dimension at least
( 1 + ( n - 1 )*abs( INCY ) ).
Before entry, the incremented array Y must contain the n
element vector y. On exit, Y is overwritten by the updated
vector y.
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
