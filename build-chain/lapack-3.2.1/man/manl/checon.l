.TH  CHECON 1 "November 2008" " LAPACK routine (version 3.2) " " LAPACK routine (version 3.2) " 
.SH NAME
CHECON - estimates the reciprocal of the condition number of a complex Hermitian matrix A using the factorization A = U*D*U**H or A = L*D*L**H computed by CHETRF
.SH SYNOPSIS
.TP 19
SUBROUTINE CHECON(
UPLO, N, A, LDA, IPIV, ANORM, RCOND, WORK,
INFO )
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
REAL
ANORM, RCOND
.TP 19
.ti +4
INTEGER
IPIV( * )
.TP 19
.ti +4
COMPLEX
A( LDA, * ), WORK( * )
.SH PURPOSE
CHECON estimates the reciprocal of the condition number of a complex
Hermitian matrix A using the factorization A = U*D*U**H or
A = L*D*L**H computed by CHETRF.
An estimate is obtained for norm(inv(A)), and the reciprocal of the
condition number is computed as RCOND = 1 / (ANORM * norm(inv(A))).
.SH ARGUMENTS
.TP 8
UPLO    (input) CHARACTER*1
Specifies whether the details of the factorization are stored
as an upper or lower triangular matrix.
= \(aqU\(aq:  Upper triangular, form is A = U*D*U**H;
.br
= \(aqL\(aq:  Lower triangular, form is A = L*D*L**H.
.TP 8
N       (input) INTEGER
The order of the matrix A.  N >= 0.
.TP 8
A       (input) COMPLEX array, dimension (LDA,N)
The block diagonal matrix D and the multipliers used to
obtain the factor U or L as computed by CHETRF.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,N).
.TP 8
IPIV    (input) INTEGER array, dimension (N)
Details of the interchanges and the block structure of D
as determined by CHETRF.
.TP 8
ANORM   (input) REAL
The 1-norm of the original matrix A.
.TP 8
RCOND   (output) REAL
The reciprocal of the condition number of the matrix A,
computed as RCOND = 1/(ANORM * AINVNM), where AINVNM is an
estimate of the 1-norm of inv(A) computed in this routine.
.TP 8
WORK    (workspace) COMPLEX array, dimension (2*N)
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
