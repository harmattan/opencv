.TH  ZLAEIN 1 "November 2008" " LAPACK auxiliary routine (version 3.2) " " LAPACK auxiliary routine (version 3.2) " 
.SH NAME
ZLAEIN - uses inverse iteration to find a right or left eigenvector corresponding to the eigenvalue W of a complex upper Hessenberg matrix H
.SH SYNOPSIS
.TP 19
SUBROUTINE ZLAEIN(
RIGHTV, NOINIT, N, H, LDH, W, V, B, LDB, RWORK,
EPS3, SMLNUM, INFO )
.TP 19
.ti +4
LOGICAL
NOINIT, RIGHTV
.TP 19
.ti +4
INTEGER
INFO, LDB, LDH, N
.TP 19
.ti +4
DOUBLE
PRECISION EPS3, SMLNUM
.TP 19
.ti +4
COMPLEX*16
W
.TP 19
.ti +4
DOUBLE
PRECISION RWORK( * )
.TP 19
.ti +4
COMPLEX*16
B( LDB, * ), H( LDH, * ), V( * )
.SH PURPOSE
ZLAEIN uses inverse iteration to find a right or left eigenvector
corresponding to the eigenvalue W of a complex upper Hessenberg
matrix H.
.SH ARGUMENTS
.TP 9
RIGHTV   (input) LOGICAL
= .TRUE. : compute right eigenvector;
.br
= .FALSE.: compute left eigenvector.
.TP 9
NOINIT   (input) LOGICAL
.br
= .TRUE. : no initial vector supplied in V
.br
= .FALSE.: initial vector supplied in V.
.TP 8
N       (input) INTEGER
The order of the matrix H.  N >= 0.
.TP 8
H       (input) COMPLEX*16 array, dimension (LDH,N)
The upper Hessenberg matrix H.
.TP 8
LDH     (input) INTEGER
The leading dimension of the array H.  LDH >= max(1,N).
.TP 8
W       (input) COMPLEX*16
The eigenvalue of H whose corresponding right or left
eigenvector is to be computed.
.TP 8
V       (input/output) COMPLEX*16 array, dimension (N)
On entry, if NOINIT = .FALSE., V must contain a starting
vector for inverse iteration; otherwise V need not be set.
On exit, V contains the computed eigenvector, normalized so
that the component of largest magnitude has magnitude 1; here
the magnitude of a complex number (x,y) is taken to be
|x| + |y|.
.TP 8
B       (workspace) COMPLEX*16 array, dimension (LDB,N)
.TP 8
LDB     (input) INTEGER
The leading dimension of the array B.  LDB >= max(1,N).
.TP 8
RWORK   (workspace) DOUBLE PRECISION array, dimension (N)
.TP 8
EPS3    (input) DOUBLE PRECISION
A small machine-dependent value which is used to perturb
close eigenvalues, and to replace zero pivots.
.TP 8
SMLNUM  (input) DOUBLE PRECISION
A machine-dependent value close to the underflow threshold.
.TP 8
INFO    (output) INTEGER
= 0:  successful exit
.br
= 1:  inverse iteration did not converge; V is set to the
last iterate.
