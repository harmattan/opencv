.TH  DPOEQUB 1 "November 2008" "    LAPACK routine (version 3.2)                                 " "    LAPACK routine (version 3.2)                                 " 
.SH NAME
DPOEQUB - computes row and column scalings intended to equilibrate a symmetric positive definite matrix A and reduce its condition number (with respect to the two-norm)
.SH SYNOPSIS
.TP 20
SUBROUTINE DPOEQUB(
N, A, LDA, S, SCOND, AMAX, INFO )
.TP 20
.ti +4
IMPLICIT
NONE
.TP 20
.ti +4
INTEGER
INFO, LDA, N
.TP 20
.ti +4
DOUBLE
PRECISION AMAX, SCOND
.TP 20
.ti +4
DOUBLE
PRECISION A( LDA, * ), S( * )
.SH PURPOSE
DPOEQU computes row and column scalings intended to equilibrate a
symmetric positive definite matrix A and reduce its condition number
(with respect to the two-norm).  S contains the scale factors,
S(i) = 1/sqrt(A(i,i)), chosen so that the scaled matrix B with
elements B(i,j) = S(i)*A(i,j)*S(j) has ones on the diagonal.  This
choice of S puts the condition number of B within a factor N of the
smallest possible condition number over all possible diagonal
scalings.
.br
.SH ARGUMENTS
.TP 8
N       (input) INTEGER
The order of the matrix A.  N >= 0.
.TP 8
A       (input) DOUBLE PRECISION array, dimension (LDA,N)
The N-by-N symmetric positive definite matrix whose scaling
factors are to be computed.  Only the diagonal elements of A
are referenced.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,N).
.TP 8
S       (output) DOUBLE PRECISION array, dimension (N)
If INFO = 0, S contains the scale factors for A.
.TP 8
SCOND   (output) DOUBLE PRECISION
If INFO = 0, S contains the ratio of the smallest S(i) to
the largest S(i).  If SCOND >= 0.1 and AMAX is neither too
large nor too small, it is not worth scaling by S.
.TP 8
AMAX    (output) DOUBLE PRECISION
Absolute value of largest matrix element.  If AMAX is very
close to overflow or very close to underflow, the matrix
should be scaled.
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value
.br
> 0:  if INFO = i, the i-th diagonal element is nonpositive.
