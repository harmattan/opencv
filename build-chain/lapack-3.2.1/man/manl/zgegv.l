.TH  ZGEGV 1 "November 2008" " LAPACK driver routine (version 3.2) " " LAPACK driver routine (version 3.2) " 
.SH NAME
ZGEGV - routine i deprecated and has been replaced by routine ZGGEV
.SH SYNOPSIS
.TP 18
SUBROUTINE ZGEGV(
JOBVL, JOBVR, N, A, LDA, B, LDB, ALPHA, BETA,
VL, LDVL, VR, LDVR, WORK, LWORK, RWORK, INFO )
.TP 18
.ti +4
CHARACTER
JOBVL, JOBVR
.TP 18
.ti +4
INTEGER
INFO, LDA, LDB, LDVL, LDVR, LWORK, N
.TP 18
.ti +4
DOUBLE
PRECISION RWORK( * )
.TP 18
.ti +4
COMPLEX*16
A( LDA, * ), ALPHA( * ), B( LDB, * ),
BETA( * ), VL( LDVL, * ), VR( LDVR, * ),
WORK( * )
.SH PURPOSE
This routine is deprecated and has been replaced by routine ZGGEV.
ZGEGV computes the eigenvalues and, optionally, the left and/or right
eigenvectors of a complex matrix pair (A,B).
.br
Given two square matrices A and B,
.br
the generalized nonsymmetric eigenvalue problem (GNEP) is to find the
eigenvalues lambda and corresponding (non-zero) eigenvectors x such
that
.br
   A*x = lambda*B*x.
.br
An alternate form is to find the eigenvalues mu and corresponding
eigenvectors y such that
.br
   mu*A*y = B*y.
.br
These two forms are equivalent with mu = 1/lambda and x = y if
neither lambda nor mu is zero.  In order to deal with the case that
lambda or mu is zero or small, two values alpha and beta are returned
for each eigenvalue, such that lambda = alpha/beta and
.br
mu = beta/alpha.
.br
The vectors x and y in the above equations are right eigenvectors of
the matrix pair (A,B).  Vectors u and v satisfying
.br
   u**H*A = lambda*u**H*B  or  mu*v**H*A = v**H*B
.br
are left eigenvectors of (A,B).
.br
Note: this routine performs "full balancing" on A and B -- see
"Further Details", below.
.br
.SH ARGUMENTS
.TP 8
JOBVL   (input) CHARACTER*1
= \(aqN\(aq:  do not compute the left generalized eigenvectors;
.br
= \(aqV\(aq:  compute the left generalized eigenvectors (returned
in VL).
.TP 8
JOBVR   (input) CHARACTER*1
= \(aqN\(aq:  do not compute the right generalized eigenvectors;
.br
= \(aqV\(aq:  compute the right generalized eigenvectors (returned
in VR).
.TP 8
N       (input) INTEGER
The order of the matrices A, B, VL, and VR.  N >= 0.
.TP 8
A       (input/output) COMPLEX*16 array, dimension (LDA, N)
On entry, the matrix A.
If JOBVL = \(aqV\(aq or JOBVR = \(aqV\(aq, then on exit A
contains the Schur form of A from the generalized Schur
factorization of the pair (A,B) after balancing.  If no
eigenvectors were computed, then only the diagonal elements
of the Schur form will be correct.  See ZGGHRD and ZHGEQZ
for details.
.TP 8
LDA     (input) INTEGER
The leading dimension of A.  LDA >= max(1,N).
.TP 8
B       (input/output) COMPLEX*16 array, dimension (LDB, N)
On entry, the matrix B.
If JOBVL = \(aqV\(aq or JOBVR = \(aqV\(aq, then on exit B contains the
upper triangular matrix obtained from B in the generalized
Schur factorization of the pair (A,B) after balancing.
If no eigenvectors were computed, then only the diagonal
elements of B will be correct.  See ZGGHRD and ZHGEQZ for
details.
.TP 8
LDB     (input) INTEGER
The leading dimension of B.  LDB >= max(1,N).
.TP 8
ALPHA   (output) COMPLEX*16 array, dimension (N)
The complex scalars alpha that define the eigenvalues of
GNEP.
.TP 8
BETA    (output) COMPLEX*16 array, dimension (N)
The complex scalars beta that define the eigenvalues of GNEP.
Together, the quantities alpha = ALPHA(j) and beta = BETA(j)
represent the j-th eigenvalue of the matrix pair (A,B), in
one of the forms lambda = alpha/beta or mu = beta/alpha.
Since either lambda or mu may overflow, they should not,
in general, be computed.
.TP 8
VL      (output) COMPLEX*16 array, dimension (LDVL,N)
If JOBVL = \(aqV\(aq, the left eigenvectors u(j) are stored
in the columns of VL, in the same order as their eigenvalues.
Each eigenvector is scaled so that its largest component has
abs(real part) + abs(imag. part) = 1, except for eigenvectors
corresponding to an eigenvalue with alpha = beta = 0, which
are set to zero.
Not referenced if JOBVL = \(aqN\(aq.
.TP 8
LDVL    (input) INTEGER
The leading dimension of the matrix VL. LDVL >= 1, and
if JOBVL = \(aqV\(aq, LDVL >= N.
.TP 8
VR      (output) COMPLEX*16 array, dimension (LDVR,N)
If JOBVR = \(aqV\(aq, the right eigenvectors x(j) are stored
in the columns of VR, in the same order as their eigenvalues.
Each eigenvector is scaled so that its largest component has
abs(real part) + abs(imag. part) = 1, except for eigenvectors
corresponding to an eigenvalue with alpha = beta = 0, which
are set to zero.
Not referenced if JOBVR = \(aqN\(aq.
.TP 8
LDVR    (input) INTEGER
The leading dimension of the matrix VR. LDVR >= 1, and
if JOBVR = \(aqV\(aq, LDVR >= N.
.TP 8
WORK    (workspace/output) COMPLEX*16 array, dimension (MAX(1,LWORK))
On exit, if INFO = 0, WORK(1) returns the optimal LWORK.
.TP 8
LWORK   (input) INTEGER
The dimension of the array WORK.  LWORK >= max(1,2*N).
For good performance, LWORK must generally be larger.
To compute the optimal value of LWORK, call ILAENV to get
blocksizes (for ZGEQRF, ZUNMQR, and ZUNGQR.)  Then compute:
NB  -- MAX of the blocksizes for ZGEQRF, ZUNMQR, and ZUNGQR;
The optimal LWORK is  MAX( 2*N, N*(NB+1) ).
If LWORK = -1, then a workspace query is assumed; the routine
only calculates the optimal size of the WORK array, returns
this value as the first entry of the WORK array, and no error
message related to LWORK is issued by XERBLA.
.TP 8
RWORK   (workspace/output) DOUBLE PRECISION array, dimension (8*N)
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
< 0:  if INFO = -i, the i-th argument had an illegal value.
.br
=1,...,N:
The QZ iteration failed.  No eigenvectors have been
calculated, but ALPHA(j) and BETA(j) should be
correct for j=INFO+1,...,N.
> N:  errors that usually indicate LAPACK problems:
.br
=N+1: error return from ZGGBAL
.br
=N+2: error return from ZGEQRF
.br
=N+3: error return from ZUNMQR
.br
=N+4: error return from ZUNGQR
.br
=N+5: error return from ZGGHRD
.br
=N+6: error return from ZHGEQZ (other than failed
iteration)
=N+7: error return from ZTGEVC
.br
=N+8: error return from ZGGBAK (computing VL)
.br
=N+9: error return from ZGGBAK (computing VR)
.br
=N+10: error return from ZLASCL (various calls)
.SH FURTHER DETAILS
Balancing
.br
---------
.br
This driver calls ZGGBAL to both permute and scale rows and columns
of A and B.  The permutations PL and PR are chosen so that PL*A*PR
and PL*B*R will be upper triangular except for the diagonal blocks
A(i:j,i:j) and B(i:j,i:j), with i and j as close together as
possible.  The diagonal scaling matrices DL and DR are chosen so
that the pair  DL*PL*A*PR*DR, DL*PL*B*PR*DR have elements close to
one (except for the elements that start out zero.)
.br
After the eigenvalues and eigenvectors of the balanced matrices
have been computed, ZGGBAK transforms the eigenvectors back to what
they would have been (in perfect arithmetic) if they had not been
balanced.
.br
Contents of A and B on Exit
.br
-------- -- - --- - -- ----
.br
If any eigenvectors are computed (either JOBVL=\(aqV\(aq or JOBVR=\(aqV\(aq or
both), then on exit the arrays A and B will contain the complex Schur
form[*] of the "balanced" versions of A and B.  If no eigenvectors
are computed, then only the diagonal blocks will be correct.
[*] In other words, upper triangular form.
.br
