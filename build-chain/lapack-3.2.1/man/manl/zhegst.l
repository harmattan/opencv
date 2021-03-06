.TH  ZHEGST 1 "November 2008" " LAPACK routine (version 3.2) " " LAPACK routine (version 3.2) " 
.SH NAME
ZHEGST - reduces a complex Hermitian-definite generalized eigenproblem to standard form
.SH SYNOPSIS
.TP 19
SUBROUTINE ZHEGST(
ITYPE, UPLO, N, A, LDA, B, LDB, INFO )
.TP 19
.ti +4
CHARACTER
UPLO
.TP 19
.ti +4
INTEGER
INFO, ITYPE, LDA, LDB, N
.TP 19
.ti +4
COMPLEX*16
A( LDA, * ), B( LDB, * )
.SH PURPOSE
ZHEGST reduces a complex Hermitian-definite generalized
eigenproblem to standard form.
If ITYPE = 1, the problem is A*x = lambda*B*x,
.br
and A is overwritten by inv(U**H)*A*inv(U) or inv(L)*A*inv(L**H)
If ITYPE = 2 or 3, the problem is A*B*x = lambda*x or
.br
B*A*x = lambda*x, and A is overwritten by U*A*U**H or L**H*A*L.
B must have been previously factorized as U**H*U or L*L**H by ZPOTRF.
.SH ARGUMENTS
.TP 8
ITYPE   (input) INTEGER
= 1: compute inv(U**H)*A*inv(U) or inv(L)*A*inv(L**H);
.br
= 2 or 3: compute U*A*U**H or L**H*A*L.
.TP 8
UPLO    (input) CHARACTER*1
.br
= \(aqU\(aq:  Upper triangle of A is stored and B is factored as
U**H*U;
= \(aqL\(aq:  Lower triangle of A is stored and B is factored as
L*L**H.
.TP 8
N       (input) INTEGER
The order of the matrices A and B.  N >= 0.
.TP 8
A       (input/output) COMPLEX*16 array, dimension (LDA,N)
On entry, the Hermitian matrix A.  If UPLO = \(aqU\(aq, the leading
N-by-N upper triangular part of A contains the upper
triangular part of the matrix A, and the strictly lower
triangular part of A is not referenced.  If UPLO = \(aqL\(aq, the
leading N-by-N lower triangular part of A contains the lower
triangular part of the matrix A, and the strictly upper
triangular part of A is not referenced.
On exit, if INFO = 0, the transformed matrix, stored in the
same format as A.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,N).
.TP 8
B       (input) COMPLEX*16 array, dimension (LDB,N)
The triangular factor from the Cholesky factorization of B,
as returned by ZPOTRF.
.TP 8
LDB     (input) INTEGER
The leading dimension of the array B.  LDB >= max(1,N).
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
