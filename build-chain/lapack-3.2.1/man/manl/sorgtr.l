.TH  SORGTR 1 "November 2008" " LAPACK routine (version 3.2) " " LAPACK routine (version 3.2) " 
.SH NAME
SORGTR - generates a real orthogonal matrix Q which is defined as the product of n-1 elementary reflectors of order N, as returned by SSYTRD
.SH SYNOPSIS
.TP 19
SUBROUTINE SORGTR(
UPLO, N, A, LDA, TAU, WORK, LWORK, INFO )
.TP 19
.ti +4
CHARACTER
UPLO
.TP 19
.ti +4
INTEGER
INFO, LDA, LWORK, N
.TP 19
.ti +4
REAL
A( LDA, * ), TAU( * ), WORK( * )
.SH PURPOSE
SORGTR generates a real orthogonal matrix Q which is defined as the
product of n-1 elementary reflectors of order N, as returned by
SSYTRD:
if UPLO = \(aqU\(aq, Q = H(n-1) . . . H(2) H(1),
.br
if UPLO = \(aqL\(aq, Q = H(1) H(2) . . . H(n-1).
.br
.SH ARGUMENTS
.TP 8
UPLO    (input) CHARACTER*1
= \(aqU\(aq: Upper triangle of A contains elementary reflectors
from SSYTRD;
= \(aqL\(aq: Lower triangle of A contains elementary reflectors
from SSYTRD.
.TP 8
N       (input) INTEGER
The order of the matrix Q. N >= 0.
.TP 8
A       (input/output) REAL array, dimension (LDA,N)
On entry, the vectors which define the elementary reflectors,
as returned by SSYTRD.
On exit, the N-by-N orthogonal matrix Q.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A. LDA >= max(1,N).
.TP 8
TAU     (input) REAL array, dimension (N-1)
TAU(i) must contain the scalar factor of the elementary
reflector H(i), as returned by SSYTRD.
.TP 8
WORK    (workspace/output) REAL array, dimension (MAX(1,LWORK))
On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
.TP 8
LWORK   (input) INTEGER
The dimension of the array WORK. LWORK >= max(1,N-1).
For optimum performance LWORK >= (N-1)*NB, where NB is
the optimal blocksize.
If LWORK = -1, then a workspace query is assumed; the routine
only calculates the optimal size of the WORK array, returns
this value as the first entry of the WORK array, and no error
message related to LWORK is issued by XERBLA.
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
