.TH  ZTPTTR 1 "November 2008" " LAPACK routine (version 3.2)                                    " " LAPACK routine (version 3.2)                                    " 
.SH NAME
ZTPTTR - copies a triangular matrix A from standard packed format (TP) to standard full format (TR)
.SH SYNOPSIS
.TP 19
SUBROUTINE ZTPTTR(
UPLO, N, AP, A, LDA, INFO )
.TP 19
.ti +4
CHARACTER
UPLO
.TP 19
.ti +4
INTEGER
INFO, N, LDA
.TP 19
.ti +4
COMPLEX*16
A( LDA, * ), AP( * )
.SH PURPOSE
ZTPTTR copies a triangular matrix A from standard packed format (TP)
to standard full format (TR).
.SH ARGUMENTS
.TP 8
UPLO    (input) CHARACTER
= \(aqU\(aq:  A is upper triangular.
.br
= \(aqL\(aq:  A is lower triangular.
.TP 8
N       (input) INTEGER
The order of the matrix A. N >= 0.
.TP 8
AP      (input) COMPLEX*16 array, dimension ( N*(N+1)/2 ),
On entry, the upper or lower triangular matrix A, packed
columnwise in a linear array. The j-th column of A is stored
in the array AP as follows:
if UPLO = \(aqU\(aq, AP(i + (j-1)*j/2) = A(i,j) for 1<=i<=j;
if UPLO = \(aqL\(aq, AP(i + (j-1)*(2n-j)/2) = A(i,j) for j<=i<=n.
.TP 8
A       (output) COMPLEX*16 array, dimension ( LDA, N )
On exit, the triangular matrix A.  If UPLO = \(aqU\(aq, the leading
N-by-N upper triangular part of A contains the upper
triangular part of the matrix A, and the strictly lower
triangular part of A is not referenced.  If UPLO = \(aqL\(aq, the
leading N-by-N lower triangular part of A contains the lower
triangular part of the matrix A, and the strictly upper
triangular part of A is not referenced.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,N).
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
