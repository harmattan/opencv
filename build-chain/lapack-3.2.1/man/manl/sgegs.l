.TH  SGEGS 1 "November 2008" " LAPACK driver routine (version 3.2) " " LAPACK driver routine (version 3.2) " 
.SH NAME
SGEGS - routine i deprecated and has been replaced by routine SGGES
.SH SYNOPSIS
.TP 18
SUBROUTINE SGEGS(
JOBVSL, JOBVSR, N, A, LDA, B, LDB, ALPHAR,
ALPHAI, BETA, VSL, LDVSL, VSR, LDVSR, WORK,
LWORK, INFO )
.TP 18
.ti +4
CHARACTER
JOBVSL, JOBVSR
.TP 18
.ti +4
INTEGER
INFO, LDA, LDB, LDVSL, LDVSR, LWORK, N
.TP 18
.ti +4
REAL
A( LDA, * ), ALPHAI( * ), ALPHAR( * ),
B( LDB, * ), BETA( * ), VSL( LDVSL, * ),
VSR( LDVSR, * ), WORK( * )
.SH PURPOSE
This routine is deprecated and has been replaced by routine SGGES.
SGEGS computes the eigenvalues, real Schur form, and, optionally,
left and or/right Schur vectors of a real matrix pair (A,B).
Given two square matrices A and B, the generalized real Schur
factorization has the form
.br
.br
  A = Q*S*Z**T,  B = Q*T*Z**T
.br
where Q and Z are orthogonal matrices, T is upper triangular, and S
is an upper quasi-triangular matrix with 1-by-1 and 2-by-2 diagonal
blocks, the 2-by-2 blocks corresponding to complex conjugate pairs
of eigenvalues of (A,B).  The columns of Q are the left Schur vectors
and the columns of Z are the right Schur vectors.
.br
.br
If only the eigenvalues of (A,B) are needed, the driver routine
SGEGV should be used instead.  See SGEGV for a description of the
eigenvalues of the generalized nonsymmetric eigenvalue problem
(GNEP).
.br
.SH ARGUMENTS
.TP 8
JOBVSL  (input) CHARACTER*1
= \(aqN\(aq:  do not compute the left Schur vectors;
.br
= \(aqV\(aq:  compute the left Schur vectors (returned in VSL).
.TP 8
JOBVSR  (input) CHARACTER*1
.br
= \(aqN\(aq:  do not compute the right Schur vectors;
.br
= \(aqV\(aq:  compute the right Schur vectors (returned in VSR).
.TP 8
N       (input) INTEGER
The order of the matrices A, B, VSL, and VSR.  N >= 0.
.TP 8
A       (input/output) REAL array, dimension (LDA, N)
On entry, the matrix A.
On exit, the upper quasi-triangular matrix S from the
generalized real Schur factorization.
.TP 8
LDA     (input) INTEGER
The leading dimension of A.  LDA >= max(1,N).
.TP 8
B       (input/output) REAL array, dimension (LDB, N)
On entry, the matrix B.
On exit, the upper triangular matrix T from the generalized
real Schur factorization.
.TP 8
LDB     (input) INTEGER
The leading dimension of B.  LDB >= max(1,N).
.TP 8
ALPHAR  (output) REAL array, dimension (N)
The real parts of each scalar alpha defining an eigenvalue
of GNEP.
.TP 8
ALPHAI  (output) REAL array, dimension (N)
The imaginary parts of each scalar alpha defining an
eigenvalue of GNEP.  If ALPHAI(j) is zero, then the j-th
eigenvalue is real; if positive, then the j-th and (j+1)-st
eigenvalues are a complex conjugate pair, with
ALPHAI(j+1) = -ALPHAI(j).
.TP 8
BETA    (output) REAL array, dimension (N)
The scalars beta that define the eigenvalues of GNEP.
Together, the quantities alpha = (ALPHAR(j),ALPHAI(j)) and
beta = BETA(j) represent the j-th eigenvalue of the matrix
pair (A,B), in one of the forms lambda = alpha/beta or
mu = beta/alpha.  Since either lambda or mu may overflow,
they should not, in general, be computed.
.TP 8
VSL     (output) REAL array, dimension (LDVSL,N)
If JOBVSL = \(aqV\(aq, the matrix of left Schur vectors Q.
Not referenced if JOBVSL = \(aqN\(aq.
.TP 8
LDVSL   (input) INTEGER
The leading dimension of the matrix VSL. LDVSL >=1, and
if JOBVSL = \(aqV\(aq, LDVSL >= N.
.TP 8
VSR     (output) REAL array, dimension (LDVSR,N)
If JOBVSR = \(aqV\(aq, the matrix of right Schur vectors Z.
Not referenced if JOBVSR = \(aqN\(aq.
.TP 8
LDVSR   (input) INTEGER
The leading dimension of the matrix VSR. LDVSR >= 1, and
if JOBVSR = \(aqV\(aq, LDVSR >= N.
.TP 8
WORK    (workspace/output) REAL array, dimension (MAX(1,LWORK))
On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
.TP 8
LWORK   (input) INTEGER
The dimension of the array WORK.  LWORK >= max(1,4*N).
For good performance, LWORK must generally be larger.
To compute the optimal value of LWORK, call ILAENV to get
blocksizes (for SGEQRF, SORMQR, and SORGQR.)  Then compute:
NB  -- MAX of the blocksizes for SGEQRF, SORMQR, and SORGQR
The optimal LWORK is  2*N + N*(NB+1).
If LWORK = -1, then a workspace query is assumed; the routine
only calculates the optimal size of the WORK array, returns
this value as the first entry of the WORK array, and no error
message related to LWORK is issued by XERBLA.
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value.
.br
= 1,...,N:
The QZ iteration failed.  (A,B) are not in Schur
form, but ALPHAR(j), ALPHAI(j), and BETA(j) should
be correct for j=INFO+1,...,N.
> N:  errors that usually indicate LAPACK problems:
.br
=N+1: error return from SGGBAL
.br
=N+2: error return from SGEQRF
.br
=N+3: error return from SORMQR
.br
=N+4: error return from SORGQR
.br
=N+5: error return from SGGHRD
.br
=N+6: error return from SHGEQZ (other than failed
iteration)
=N+7: error return from SGGBAK (computing VSL)
.br
=N+8: error return from SGGBAK (computing VSR)
.br
=N+9: error return from SLASCL (various places)
