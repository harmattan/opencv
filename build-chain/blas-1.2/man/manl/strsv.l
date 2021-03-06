.TH STRSV l "16 October 1992" "BLAS routine" "BLAS routine"
.SH NAME
STRSV - solve one of the systems of equations   A*x = b, or A'*x = b,
.SH SYNOPSIS
.TP 17
SUBROUTINE STRSV
( UPLO, TRANS, DIAG, N, A, LDA, X, INCX )
.TP 17
.ti +4
INTEGER
INCX, LDA, N
.TP 17
.ti +4
CHARACTER*1
DIAG, TRANS, UPLO
.TP 17
.ti +4
REAL
A( LDA, * ), X( * )
.SH PURPOSE
STRSV  solves one of the systems of equations

where b and x are n element vectors and A is an n by n unit, or
non-unit, upper or lower triangular matrix.
.br

No test for singularity or near-singularity is included in this
routine. Such tests must be performed before calling this routine.

.SH PARAMETERS
.TP 7
UPLO   - CHARACTER*1.
On entry, UPLO specifies whether the matrix is an upper or
lower triangular matrix as follows:

UPLO = 'U' or 'u'   A is an upper triangular matrix.

UPLO = 'L' or 'l'   A is a lower triangular matrix.

Unchanged on exit.
.TP 7
TRANS  - CHARACTER*1.
On entry, TRANS specifies the equations to be solved as
follows:

TRANS = 'N' or 'n'   A*x = b.

TRANS = 'T' or 't'   A'*x = b.

TRANS = 'C' or 'c'   A'*x = b.

Unchanged on exit.
.TP 7
DIAG   - CHARACTER*1.
On entry, DIAG specifies whether or not A is unit
triangular as follows:

DIAG = 'U' or 'u'   A is assumed to be unit triangular.

DIAG = 'N' or 'n'   A is not assumed to be unit
triangular.

Unchanged on exit.
.TP 7
N      - INTEGER.
On entry, N specifies the order of the matrix A.
N must be at least zero.
Unchanged on exit.
.TP 7
A      - REAL             array of DIMENSION ( LDA, n ).
Before entry with  UPLO = 'U' or 'u', the leading n by n
upper triangular part of the array A must contain the upper
triangular matrix and the strictly lower triangular part of
A is not referenced.
Before entry with UPLO = 'L' or 'l', the leading n by n
lower triangular part of the array A must contain the lower
triangular matrix and the strictly upper triangular part of
A is not referenced.
Note that when  DIAG = 'U' or 'u', the diagonal elements of
A are not referenced either, but are assumed to be unity.
Unchanged on exit.
.TP 7
LDA    - INTEGER.
On entry, LDA specifies the first dimension of A as declared
in the calling (sub) program. LDA must be at least
max( 1, n ).
Unchanged on exit.
.TP 7
X      - REAL             array of dimension at least
( 1 + ( n - 1 )*abs( INCX ) ).
Before entry, the incremented array X must contain the n
element right-hand side vector b. On exit, X is overwritten
with the solution vector x.
.TP 7
INCX   - INTEGER.
On entry, INCX specifies the increment for the elements of
X. INCX must not be zero.
Unchanged on exit.

Level 2 Blas routine.

-- Written on 22-October-1986.
Jack Dongarra, Argonne National Lab.
Jeremy Du Croz, Nag Central Office.
Sven Hammarling, Nag Central Office.
Richard Hanson, Sandia National Labs.
