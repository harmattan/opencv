.TH CHER2K l "16 October 1992" "BLAS routine" "BLAS routine"
.SH NAME
CHER2K - perform one of the hermitian rank 2k operations   C := alpha*A*conjg( B' ) + conjg( alpha )*B*conjg( A' ) + beta*C,
.SH SYNOPSIS
.TP 19
SUBROUTINE CHER2K(
UPLO, TRANS, N, K, ALPHA, A, LDA, B, LDB,
BETA, C, LDC )
.TP 19
.ti +4
CHARACTER*1
UPLO, TRANS
.TP 19
.ti +4
INTEGER
N, K, LDA, LDB, LDC
.TP 19
.ti +4
REAL
BETA
.TP 19
.ti +4
COMPLEX
ALPHA
.TP 19
.ti +4
COMPLEX
A( LDA, * ), B( LDB, * ), C( LDC, * )
.SH PURPOSE
CHER2K  performs one of the hermitian rank 2k operations

or
.br

   C := alpha*conjg( A' )*B + conjg( alpha )*conjg( B' )*A + beta*C,

where  alpha and beta  are scalars with  beta  real,  C is an  n by n
hermitian matrix and  A and B  are  n by k matrices in the first case
and  k by n  matrices in the second case.
.br

.SH PARAMETERS
.TP 7
UPLO   - CHARACTER*1.
On  entry,   UPLO  specifies  whether  the  upper  or  lower
triangular  part  of the  array  C  is to be  referenced  as
follows:

UPLO = 'U' or 'u'   Only the  upper triangular part of  C
is to be referenced.

UPLO = 'L' or 'l'   Only the  lower triangular part of  C
is to be referenced.

Unchanged on exit.
.TP 7
TRANS  - CHARACTER*1.
On entry,  TRANS  specifies the operation to be performed as
follows:

TRANS = 'N' or 'n'    C := alpha*A*conjg( B' )          +
conjg( alpha )*B*conjg( A' ) +
beta*C.

TRANS = 'C' or 'c'    C := alpha*conjg( A' )*B          +
conjg( alpha )*conjg( B' )*A +
beta*C.

Unchanged on exit.
.TP 7
N      - INTEGER.
On entry,  N specifies the order of the matrix C.  N must be
at least zero.
Unchanged on exit.
.TP 7
K      - INTEGER.
On entry with  TRANS = 'N' or 'n',  K  specifies  the number
of  columns  of the  matrices  A and B,  and on  entry  with
TRANS = 'C' or 'c',  K  specifies  the number of rows of the
matrices  A and B.  K must be at least zero.
Unchanged on exit.
.TP 7
ALPHA  - COMPLEX         .
On entry, ALPHA specifies the scalar alpha.
Unchanged on exit.
.TP 7
A      - COMPLEX          array of DIMENSION ( LDA, ka ), where ka is
k  when  TRANS = 'N' or 'n',  and is  n  otherwise.
Before entry with  TRANS = 'N' or 'n',  the  leading  n by k
part of the array  A  must contain the matrix  A,  otherwise
the leading  k by n  part of the array  A  must contain  the
matrix A.
Unchanged on exit.
.TP 7
LDA    - INTEGER.
On entry, LDA specifies the first dimension of A as declared
in  the  calling  (sub)  program.   When  TRANS = 'N' or 'n'
then  LDA must be at least  max( 1, n ), otherwise  LDA must
be at least  max( 1, k ).
Unchanged on exit.
.TP 7
B      - COMPLEX          array of DIMENSION ( LDB, kb ), where kb is
k  when  TRANS = 'N' or 'n',  and is  n  otherwise.
Before entry with  TRANS = 'N' or 'n',  the  leading  n by k
part of the array  B  must contain the matrix  B,  otherwise
the leading  k by n  part of the array  B  must contain  the
matrix B.
Unchanged on exit.
.TP 7
LDB    - INTEGER.
On entry, LDB specifies the first dimension of B as declared
in  the  calling  (sub)  program.   When  TRANS = 'N' or 'n'
then  LDB must be at least  max( 1, n ), otherwise  LDB must
be at least  max( 1, k ).
Unchanged on exit.
.TP 7
BETA   - REAL            .
On entry, BETA specifies the scalar beta.
Unchanged on exit.
.TP 7
C      - COMPLEX          array of DIMENSION ( LDC, n ).
Before entry  with  UPLO = 'U' or 'u',  the leading  n by n
upper triangular part of the array C must contain the upper
triangular part  of the  hermitian matrix  and the strictly
lower triangular part of C is not referenced.  On exit, the
upper triangular part of the array  C is overwritten by the
upper triangular part of the updated matrix.
Before entry  with  UPLO = 'L' or 'l',  the leading  n by n
lower triangular part of the array C must contain the lower
triangular part  of the  hermitian matrix  and the strictly
upper triangular part of C is not referenced.  On exit, the
lower triangular part of the array  C is overwritten by the
lower triangular part of the updated matrix.
Note that the imaginary parts of the diagonal elements need
not be set,  they are assumed to be zero,  and on exit they
are set to zero.
.TP 7
LDC    - INTEGER.
On entry, LDC specifies the first dimension of C as declared
in  the  calling  (sub)  program.   LDC  must  be  at  least
max( 1, n ).
Unchanged on exit.

Level 3 Blas routine.

-- Written on 8-February-1989.
Jack Dongarra, Argonne National Laboratory.
Iain Duff, AERE Harwell.
Jeremy Du Croz, Numerical Algorithms Group Ltd.
Sven Hammarling, Numerical Algorithms Group Ltd.

.. External Functions ..

.. External Subroutines ..

.. Intrinsic Functions ..

.. Local Scalars ..
