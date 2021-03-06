.TH  ZHPEVD 1 "November 2008" " LAPACK driver routine (version 3.2) " " LAPACK driver routine (version 3.2) " 
.SH NAME
ZHPEVD - computes all the eigenvalues and, optionally, eigenvectors of a complex Hermitian matrix A in packed storage
.SH SYNOPSIS
.TP 19
SUBROUTINE ZHPEVD(
JOBZ, UPLO, N, AP, W, Z, LDZ, WORK, LWORK,
RWORK, LRWORK, IWORK, LIWORK, INFO )
.TP 19
.ti +4
CHARACTER
JOBZ, UPLO
.TP 19
.ti +4
INTEGER
INFO, LDZ, LIWORK, LRWORK, LWORK, N
.TP 19
.ti +4
INTEGER
IWORK( * )
.TP 19
.ti +4
DOUBLE
PRECISION RWORK( * ), W( * )
.TP 19
.ti +4
COMPLEX*16
AP( * ), WORK( * ), Z( LDZ, * )
.SH PURPOSE
ZHPEVD computes all the eigenvalues and, optionally, eigenvectors of
a complex Hermitian matrix A in packed storage.  If eigenvectors are
desired, it uses a divide and conquer algorithm.
.br
The divide and conquer algorithm makes very mild assumptions about
floating point arithmetic. It will work on machines with a guard
digit in add/subtract, or on those binary machines without guard
digits which subtract like the Cray X-MP, Cray Y-MP, Cray C-90, or
Cray-2. It could conceivably fail on hexadecimal or decimal machines
without guard digits, but we know of none.
.br
.SH ARGUMENTS
.TP 8
JOBZ    (input) CHARACTER*1
= \(aqN\(aq:  Compute eigenvalues only;
.br
= \(aqV\(aq:  Compute eigenvalues and eigenvectors.
.TP 8
UPLO    (input) CHARACTER*1
.br
= \(aqU\(aq:  Upper triangle of A is stored;
.br
= \(aqL\(aq:  Lower triangle of A is stored.
.TP 8
N       (input) INTEGER
The order of the matrix A.  N >= 0.
.TP 8
AP      (input/output) COMPLEX*16 array, dimension (N*(N+1)/2)
On entry, the upper or lower triangle of the Hermitian matrix
A, packed columnwise in a linear array.  The j-th column of A
is stored in the array AP as follows:
if UPLO = \(aqU\(aq, AP(i + (j-1)*j/2) = A(i,j) for 1<=i<=j;
if UPLO = \(aqL\(aq, AP(i + (j-1)*(2*n-j)/2) = A(i,j) for j<=i<=n.
On exit, AP is overwritten by values generated during the
reduction to tridiagonal form.  If UPLO = \(aqU\(aq, the diagonal
and first superdiagonal of the tridiagonal matrix T overwrite
the corresponding elements of A, and if UPLO = \(aqL\(aq, the
diagonal and first subdiagonal of T overwrite the
corresponding elements of A.
.TP 8
W       (output) DOUBLE PRECISION array, dimension (N)
If INFO = 0, the eigenvalues in ascending order.
.TP 8
Z       (output) COMPLEX*16 array, dimension (LDZ, N)
If JOBZ = \(aqV\(aq, then if INFO = 0, Z contains the orthonormal
eigenvectors of the matrix A, with the i-th column of Z
holding the eigenvector associated with W(i).
If JOBZ = \(aqN\(aq, then Z is not referenced.
.TP 8
LDZ     (input) INTEGER
The leading dimension of the array Z.  LDZ >= 1, and if
JOBZ = \(aqV\(aq, LDZ >= max(1,N).
.TP 8
WORK    (workspace/output) COMPLEX*16 array, dimension (MAX(1,LWORK))
On exit, if INFO = 0, WORK(1) returns the required LWORK.
.TP 8
LWORK   (input) INTEGER
The dimension of array WORK.
If N <= 1,               LWORK must be at least 1.
If JOBZ = \(aqN\(aq and N > 1, LWORK must be at least N.
If JOBZ = \(aqV\(aq and N > 1, LWORK must be at least 2*N.
If LWORK = -1, then a workspace query is assumed; the routine
only calculates the required sizes of the WORK, RWORK and
IWORK arrays, returns these values as the first entries of
the WORK, RWORK and IWORK arrays, and no error message
related to LWORK or LRWORK or LIWORK is issued by XERBLA.
.TP 8
RWORK   (workspace/output) DOUBLE PRECISION array,
dimension (LRWORK)
On exit, if INFO = 0, RWORK(1) returns the required LRWORK.
.TP 8
LRWORK  (input) INTEGER
The dimension of array RWORK.
If N <= 1,               LRWORK must be at least 1.
If JOBZ = \(aqN\(aq and N > 1, LRWORK must be at least N.
If JOBZ = \(aqV\(aq and N > 1, LRWORK must be at least
1 + 5*N + 2*N**2.
If LRWORK = -1, then a workspace query is assumed; the
routine only calculates the required sizes of the WORK, RWORK
and IWORK arrays, returns these values as the first entries
of the WORK, RWORK and IWORK arrays, and no error message
related to LWORK or LRWORK or LIWORK is issued by XERBLA.
.TP 8
IWORK   (workspace/output) INTEGER array, dimension (MAX(1,LIWORK))
On exit, if INFO = 0, IWORK(1) returns the required LIWORK.
.TP 8
LIWORK  (input) INTEGER
The dimension of array IWORK.
If JOBZ  = \(aqN\(aq or N <= 1, LIWORK must be at least 1.
If JOBZ  = \(aqV\(aq and N > 1, LIWORK must be at least 3 + 5*N.
If LIWORK = -1, then a workspace query is assumed; the
routine only calculates the required sizes of the WORK, RWORK
and IWORK arrays, returns these values as the first entries
of the WORK, RWORK and IWORK arrays, and no error message
related to LWORK or LRWORK or LIWORK is issued by XERBLA.
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value.
.br
> 0:  if INFO = i, the algorithm failed to converge; i
off-diagonal elements of an intermediate tridiagonal
form did not converge to zero.
