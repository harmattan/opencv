.TH  DHSEQR 1 "November 2008" " LAPACK driver routine (version 3.2) " " LAPACK driver routine (version 3.2) " 
.SH NAME
DHSEQR - DHSEQR compute the eigenvalues of a Hessenberg matrix H  and, optionally, the matrices T and Z from the Schur decomposition  H = Z T Z**T, where T is an upper quasi-triangular matrix (the  Schur form), and Z is the orthogonal matrix of Schur vectors
.SH SYNOPSIS
.TP 19
SUBROUTINE DHSEQR(
JOB, COMPZ, N, ILO, IHI, H, LDH, WR, WI, Z,
LDZ, WORK, LWORK, INFO )
.TP 19
.ti +4
INTEGER
IHI, ILO, INFO, LDH, LDZ, LWORK, N
.TP 19
.ti +4
CHARACTER
COMPZ, JOB
.TP 19
.ti +4
DOUBLE
PRECISION H( LDH, * ), WI( * ), WORK( * ), WR( * ),
Z( LDZ, * )
.SH PURPOSE
   DHSEQR computes the eigenvalues of a Hessenberg matrix H
   and, optionally, the matrices T and Z from the Schur decomposition
   H = Z T Z**T, where T is an upper quasi-triangular matrix (the
   Schur form), and Z is the orthogonal matrix of Schur vectors.
   Optionally Z may be postmultiplied into an input orthogonal
   matrix Q so that this routine can give the Schur factorization
   of a matrix A which has been reduced to the Hessenberg form H
   by the orthogonal matrix Q:  A = Q*H*Q**T = (QZ)*T*(QZ)**T.
.SH ARGUMENTS
.TP 6
JOB   (input) CHARACTER*1
= \(aqE\(aq:  compute eigenvalues only;
.br
= \(aqS\(aq:  compute eigenvalues and the Schur form T.
COMPZ (input) CHARACTER*1
.br
= \(aqN\(aq:  no Schur vectors are computed;
.br
= \(aqI\(aq:  Z is initialized to the unit matrix and the matrix Z
of Schur vectors of H is returned;
= \(aqV\(aq:  Z must contain an orthogonal matrix Q on entry, and
the product Q*Z is returned.
.TP 6
N     (input) INTEGER
The order of the matrix H.  N .GE. 0.
.TP 6
ILO   (input) INTEGER
IHI   (input) INTEGER
It is assumed that H is already upper triangular in rows
and columns 1:ILO-1 and IHI+1:N. ILO and IHI are normally
set by a previous call to DGEBAL, and then passed to DGEHRD
when the matrix output by DGEBAL is reduced to Hessenberg
form. Otherwise ILO and IHI should be set to 1 and N
respectively.  If N.GT.0, then 1.LE.ILO.LE.IHI.LE.N.
If N = 0, then ILO = 1 and IHI = 0.
.TP 6
H     (input/output) DOUBLE PRECISION array, dimension (LDH,N)
On entry, the upper Hessenberg matrix H.
On exit, if INFO = 0 and JOB = \(aqS\(aq, then H contains the
upper quasi-triangular matrix T from the Schur decomposition
(the Schur form); 2-by-2 diagonal blocks (corresponding to
complex conjugate pairs of eigenvalues) are returned in
standard form, with H(i,i) = H(i+1,i+1) and
H(i+1,i)*H(i,i+1).LT.0. If INFO = 0 and JOB = \(aqE\(aq, the
contents of H are unspecified on exit.  (The output value of
H when INFO.GT.0 is given under the description of INFO
below.)
Unlike earlier versions of DHSEQR, this subroutine may
explicitly H(i,j) = 0 for i.GT.j and j = 1, 2, ... ILO-1
or j = IHI+1, IHI+2, ... N.
.TP 6
LDH   (input) INTEGER
The leading dimension of the array H. LDH .GE. max(1,N).
.TP 6
WR    (output) DOUBLE PRECISION array, dimension (N)
WI    (output) DOUBLE PRECISION array, dimension (N)
The real and imaginary parts, respectively, of the computed
eigenvalues. If two eigenvalues are computed as a complex
conjugate pair, they are stored in consecutive elements of
WR and WI, say the i-th and (i+1)th, with WI(i) .GT. 0 and
WI(i+1) .LT. 0. If JOB = \(aqS\(aq, the eigenvalues are stored in
the same order as on the diagonal of the Schur form returned
in H, with WR(i) = H(i,i) and, if H(i:i+1,i:i+1) is a 2-by-2
diagonal block, WI(i) = sqrt(-H(i+1,i)*H(i,i+1)) and
WI(i+1) = -WI(i).
.TP 6
Z     (input/output) DOUBLE PRECISION array, dimension (LDZ,N)
If COMPZ = \(aqN\(aq, Z is not referenced.
If COMPZ = \(aqI\(aq, on entry Z need not be set and on exit,
if INFO = 0, Z contains the orthogonal matrix Z of the Schur
vectors of H.  If COMPZ = \(aqV\(aq, on entry Z must contain an
N-by-N matrix Q, which is assumed to be equal to the unit
matrix except for the submatrix Z(ILO:IHI,ILO:IHI). On exit,
if INFO = 0, Z contains Q*Z.
Normally Q is the orthogonal matrix generated by DORGHR
after the call to DGEHRD which formed the Hessenberg matrix
H. (The output value of Z when INFO.GT.0 is given under
the description of INFO below.)
.TP 6
LDZ   (input) INTEGER
The leading dimension of the array Z.  if COMPZ = \(aqI\(aq or
COMPZ = \(aqV\(aq, then LDZ.GE.MAX(1,N).  Otherwize, LDZ.GE.1.
.TP 6
WORK  (workspace/output) DOUBLE PRECISION array, dimension (LWORK)
On exit, if INFO = 0, WORK(1) returns an estimate of
the optimal value for LWORK.
LWORK (input) INTEGER
The dimension of the array WORK.  LWORK .GE. max(1,N)
is sufficient and delivers very good and sometimes
optimal performance.  However, LWORK as large as 11*N
may be required for optimal performance.  A workspace
query is recommended to determine the optimal workspace
size.
If LWORK = -1, then DHSEQR does a workspace query.
In this case, DHSEQR checks the input parameters and
estimates the optimal workspace size for the given
values of N, ILO and IHI.  The estimate is returned
in WORK(1).  No error message related to LWORK is
issued by XERBLA.  Neither H nor Z are accessed.
.TP 6
INFO  (output) INTEGER
=  0:  successful exit
.br
.LT. 0:  if INFO = -i, the i-th argument had an illegal
value
.GT. 0:  if INFO = i, DHSEQR failed to compute all of
.br
the eigenvalues.  Elements 1:ilo-1 and i+1:n of WR
and WI contain those eigenvalues which have been
successfully computed.  (Failures are rare.)
If INFO .GT. 0 and JOB = \(aqE\(aq, then on exit, the
remaining unconverged eigenvalues are the eigen-
values of the upper Hessenberg matrix rows and
columns ILO through INFO of the final, output
value of H.
If INFO .GT. 0 and JOB   = \(aqS\(aq, then on exit
.TP 5
(*)  (initial value of H)*U  = U*(final value of H)
where U is an orthogonal matrix.  The final
value of H is upper Hessenberg and quasi-triangular
in rows and columns INFO+1 through IHI.
If INFO .GT. 0 and COMPZ = \(aqV\(aq, then on exit
(final value of Z)  =  (initial value of Z)*U
where U is the orthogonal matrix in (*) (regard-
less of the value of JOB.)
If INFO .GT. 0 and COMPZ = \(aqI\(aq, then on exit
(final value of Z)  = U
where U is the orthogonal matrix in (*) (regard-
less of the value of JOB.)
If INFO .GT. 0 and COMPZ = \(aqN\(aq, then Z is not
accessed.
