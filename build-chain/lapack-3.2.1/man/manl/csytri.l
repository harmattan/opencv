.TH  CSYTRI 1 "November 2008" " LAPACK routine (version 3.2) " " LAPACK routine (version 3.2) " 
.SH NAME
CSYTRI - computes the inverse of a complex symmetric indefinite matrix A using the factorization A = U*D*U**T or A = L*D*L**T computed by CSYTRF
.SH SYNOPSIS
.TP 19
SUBROUTINE CSYTRI(
UPLO, N, A, LDA, IPIV, WORK, INFO )
.TP 19
.ti +4
CHARACTER
UPLO
.TP 19
.ti +4
INTEGER
INFO, LDA, N
.TP 19
.ti +4
INTEGER
IPIV( * )
.TP 19
.ti +4
COMPLEX
A( LDA, * ), WORK( * )
.SH PURPOSE
CSYTRI computes the inverse of a complex symmetric indefinite matrix
A using the factorization A = U*D*U**T or A = L*D*L**T computed by
CSYTRF.
.SH ARGUMENTS
.TP 8
UPLO    (input) CHARACTER*1
Specifies whether the details of the factorization are stored
as an upper or lower triangular matrix.
= \(aqU\(aq:  Upper triangular, form is A = U*D*U**T;
.br
= \(aqL\(aq:  Lower triangular, form is A = L*D*L**T.
.TP 8
N       (input) INTEGER
The order of the matrix A.  N >= 0.
.TP 8
A       (input/output) COMPLEX array, dimension (LDA,N)
On entry, the block diagonal matrix D and the multipliers
used to obtain the factor U or L as computed by CSYTRF.
On exit, if INFO = 0, the (symmetric) inverse of the original
matrix.  If UPLO = \(aqU\(aq, the upper triangular part of the
inverse is formed and the part of A below the diagonal is not
referenced; if UPLO = \(aqL\(aq the lower triangular part of the
inverse is formed and the part of A above the diagonal is
not referenced.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,N).
.TP 8
IPIV    (input) INTEGER array, dimension (N)
Details of the interchanges and the block structure of D
as determined by CSYTRF.
.TP 8
WORK    (workspace) COMPLEX array, dimension (2*N)
.TP 8
INFO    (output) INTEGER
= 0: successful exit
.br
< 0: if INFO = -i, the i-th argument had an illegal value
.br
> 0: if INFO = i, D(i,i) = 0; the matrix is singular and its
inverse could not be computed.
