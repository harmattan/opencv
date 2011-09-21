.TH  SLA_SYAMV 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
SLA_SYAMV - performs the matrix-vector operation   y := alpha*abs(A)*abs(x) + beta*abs(y),
.SH SYNOPSIS
.TP 22
SUBROUTINE SLA_SYAMV(
UPLO, N, ALPHA, A, LDA, X, INCX, BETA, Y,
INCY )
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
INCX, INCY, LDA, N, UPLO
.TP 22
.ti +4
REAL
A( LDA, * ), X( * ), Y( * )
.SH PURPOSE
SLA_SYAMV  performs the matrix-vector operation
where alpha and beta are scalars, x and y are vectors and A is an
n by n symmetric matrix.
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
UPLO   - INTEGER
On entry, UPLO specifies whether the upper or lower
triangular part of the array A is to be referenced as
follows:
UPLO = BLAS_UPPER   Only the upper triangular part of A
is to be referenced.
UPLO = BLAS_LOWER   Only the lower triangular part of A
is to be referenced.
Unchanged on exit.
.TP 7
N      - INTEGER.
On entry, N specifies the number of columns of the matrix A.
N must be at least zero.
Unchanged on exit.
.TP 7
ALPHA  - REAL            .
On entry, ALPHA specifies the scalar alpha.
Unchanged on exit.
.TP 7
A      - REAL             array of DIMENSION ( LDA, n ).
Before entry, the leading m by n part of the array A must
contain the matrix of coefficients.
Unchanged on exit.
.TP 7
LDA    - INTEGER.
On entry, LDA specifies the first dimension of A as declared
in the calling (sub) program. LDA must be at least
max( 1, n ).
Unchanged on exit.
.TP 7
X      - REAL             array of DIMENSION at least
( 1 + ( n - 1 )*abs( INCX ) )
Before entry, the incremented array X must contain the
vector x.
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
Y      - REAL             array of DIMENSION at least
( 1 + ( n - 1 )*abs( INCY ) )
Before entry with BETA non-zero, the incremented array Y
must contain the vector y. On exit, Y is overwritten by the
updated vector y.
.TP 7
INCY   - INTEGER.
On entry, INCY specifies the increment for the elements of
Y. INCY must not be zero.
Unchanged on exit.
.SH FURTHER DETAILS
Level 2 Blas routine.
.br
-- Written on 22-October-1986.
.br
   Jack Dongarra, Argonne National Lab.
.br
   Jeremy Du Croz, Nag Central Office.
.br
   Sven Hammarling, Nag Central Office.
.br
   Richard Hanson, Sandia National Labs.
.br
-- Modified for the absolute-value product, April 2006
.br
   Jason Riedy, UC Berkeley
.br
