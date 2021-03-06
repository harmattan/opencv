.TH  SGESDD 1 "November 2008" " LAPACK driver routine (version 3.2) " " LAPACK driver routine (version 3.2) " 
.SH NAME
SGESDD - computes the singular value decomposition (SVD) of a real M-by-N matrix A, optionally computing the left and right singular vectors
.SH SYNOPSIS
.TP 19
SUBROUTINE SGESDD(
JOBZ, M, N, A, LDA, S, U, LDU, VT, LDVT, WORK,
LWORK, IWORK, INFO )
.TP 19
.ti +4
CHARACTER
JOBZ
.TP 19
.ti +4
INTEGER
INFO, LDA, LDU, LDVT, LWORK, M, N
.TP 19
.ti +4
INTEGER
IWORK( * )
.TP 19
.ti +4
REAL
A( LDA, * ), S( * ), U( LDU, * ),
VT( LDVT, * ), WORK( * )
.SH PURPOSE
SGESDD computes the singular value decomposition (SVD) of a real
M-by-N matrix A, optionally computing the left and right singular
vectors.  If singular vectors are desired, it uses a
divide-and-conquer algorithm.
.br
The SVD is written
.br
     A = U * SIGMA * transpose(V)
.br
where SIGMA is an M-by-N matrix which is zero except for its
min(m,n) diagonal elements, U is an M-by-M orthogonal matrix, and
V is an N-by-N orthogonal matrix.  The diagonal elements of SIGMA
are the singular values of A; they are real and non-negative, and
are returned in descending order.  The first min(m,n) columns of
U and V are the left and right singular vectors of A.
.br
Note that the routine returns VT = V**T, not V.
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
Specifies options for computing all or part of the matrix U:
.br
= \(aqA\(aq:  all M columns of U and all N rows of V**T are
returned in the arrays U and VT;
= \(aqS\(aq:  the first min(M,N) columns of U and the first
min(M,N) rows of V**T are returned in the arrays U
and VT;
= \(aqO\(aq:  If M >= N, the first N columns of U are overwritten
on the array A and all rows of V**T are returned in
the array VT;
otherwise, all columns of U are returned in the
array U and the first M rows of V**T are overwritten
in the array A;
= \(aqN\(aq:  no columns of U or rows of V**T are computed.
.TP 8
M       (input) INTEGER
The number of rows of the input matrix A.  M >= 0.
.TP 8
N       (input) INTEGER
The number of columns of the input matrix A.  N >= 0.
.TP 8
A       (input/output) REAL array, dimension (LDA,N)
On entry, the M-by-N matrix A.
On exit,
if JOBZ = \(aqO\(aq,  A is overwritten with the first N columns
of U (the left singular vectors, stored
columnwise) if M >= N;
A is overwritten with the first M rows
of V**T (the right singular vectors, stored
rowwise) otherwise.
if JOBZ .ne. \(aqO\(aq, the contents of A are destroyed.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,M).
.TP 8
S       (output) REAL array, dimension (min(M,N))
The singular values of A, sorted so that S(i) >= S(i+1).
.TP 8
U       (output) REAL array, dimension (LDU,UCOL)
UCOL = M if JOBZ = \(aqA\(aq or JOBZ = \(aqO\(aq and M < N;
UCOL = min(M,N) if JOBZ = \(aqS\(aq.
If JOBZ = \(aqA\(aq or JOBZ = \(aqO\(aq and M < N, U contains the M-by-M
orthogonal matrix U;
if JOBZ = \(aqS\(aq, U contains the first min(M,N) columns of U
(the left singular vectors, stored columnwise);
if JOBZ = \(aqO\(aq and M >= N, or JOBZ = \(aqN\(aq, U is not referenced.
.TP 8
LDU     (input) INTEGER
The leading dimension of the array U.  LDU >= 1; if
JOBZ = \(aqS\(aq or \(aqA\(aq or JOBZ = \(aqO\(aq and M < N, LDU >= M.
.TP 8
VT      (output) REAL array, dimension (LDVT,N)
If JOBZ = \(aqA\(aq or JOBZ = \(aqO\(aq and M >= N, VT contains the
N-by-N orthogonal matrix V**T;
if JOBZ = \(aqS\(aq, VT contains the first min(M,N) rows of
V**T (the right singular vectors, stored rowwise);
if JOBZ = \(aqO\(aq and M < N, or JOBZ = \(aqN\(aq, VT is not referenced.
.TP 8
LDVT    (input) INTEGER
The leading dimension of the array VT.  LDVT >= 1; if
JOBZ = \(aqA\(aq or JOBZ = \(aqO\(aq and M >= N, LDVT >= N;
if JOBZ = \(aqS\(aq, LDVT >= min(M,N).
.TP 8
WORK    (workspace/output) REAL array, dimension (MAX(1,LWORK))
On exit, if INFO = 0, WORK(1) returns the optimal LWORK;
.TP 8
LWORK   (input) INTEGER
The dimension of the array WORK. LWORK >= 1.
If JOBZ = \(aqN\(aq,
LWORK >= 3*min(M,N) + max(max(M,N),6*min(M,N)).
If JOBZ = \(aqO\(aq,
LWORK >= 3*min(M,N)*min(M,N) + 
max(max(M,N),5*min(M,N)*min(M,N)+4*min(M,N)).
If JOBZ = \(aqS\(aq or \(aqA\(aq
LWORK >= 3*min(M,N)*min(M,N) +
max(max(M,N),4*min(M,N)*min(M,N)+4*min(M,N)).
For good performance, LWORK should generally be larger.
If LWORK = -1 but other input arguments are legal, WORK(1)
returns the optimal LWORK.
.TP 8
IWORK   (workspace) INTEGER array, dimension (8*min(M,N))
.TP 8
INFO    (output) INTEGER
= 0:  successful exit.
.br
< 0:  if INFO = -i, the i-th argument had an illegal value.
.br
> 0:  SBDSDC did not converge, updating process failed.
.SH FURTHER DETAILS
Based on contributions by
.br
   Ming Gu and Huan Ren, Computer Science Division, University of
   California at Berkeley, USA
.br
