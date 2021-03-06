.TH  DGGBAK 1 "November 2008" " LAPACK routine (version 3.2) " " LAPACK routine (version 3.2) " 
.SH NAME
DGGBAK - forms the right or left eigenvectors of a real generalized eigenvalue problem A*x = lambda*B*x, by backward transformation on the computed eigenvectors of the balanced pair of matrices output by DGGBAL
.SH SYNOPSIS
.TP 19
SUBROUTINE DGGBAK(
JOB, SIDE, N, ILO, IHI, LSCALE, RSCALE, M, V,
LDV, INFO )
.TP 19
.ti +4
CHARACTER
JOB, SIDE
.TP 19
.ti +4
INTEGER
IHI, ILO, INFO, LDV, M, N
.TP 19
.ti +4
DOUBLE
PRECISION LSCALE( * ), RSCALE( * ), V( LDV, * )
.SH PURPOSE
DGGBAK forms the right or left eigenvectors of a real generalized
eigenvalue problem A*x = lambda*B*x, by backward transformation on
the computed eigenvectors of the balanced pair of matrices output by
DGGBAL.
.SH ARGUMENTS
.TP 8
JOB     (input) CHARACTER*1
Specifies the type of backward transformation required:
.br
= \(aqN\(aq:  do nothing, return immediately;
.br
= \(aqP\(aq:  do backward transformation for permutation only;
.br
= \(aqS\(aq:  do backward transformation for scaling only;
.br
= \(aqB\(aq:  do backward transformations for both permutation and
scaling.
JOB must be the same as the argument JOB supplied to DGGBAL.
.TP 8
SIDE    (input) CHARACTER*1
= \(aqR\(aq:  V contains right eigenvectors;
.br
= \(aqL\(aq:  V contains left eigenvectors.
.TP 8
N       (input) INTEGER
The number of rows of the matrix V.  N >= 0.
.TP 8
ILO     (input) INTEGER
IHI     (input) INTEGER
The integers ILO and IHI determined by DGGBAL.
1 <= ILO <= IHI <= N, if N > 0; ILO=1 and IHI=0, if N=0.
.TP 8
LSCALE  (input) DOUBLE PRECISION array, dimension (N)
Details of the permutations and/or scaling factors applied
to the left side of A and B, as returned by DGGBAL.
.TP 8
RSCALE  (input) DOUBLE PRECISION array, dimension (N)
Details of the permutations and/or scaling factors applied
to the right side of A and B, as returned by DGGBAL.
.TP 8
M       (input) INTEGER
The number of columns of the matrix V.  M >= 0.
.TP 8
V       (input/output) DOUBLE PRECISION array, dimension (LDV,M)
On entry, the matrix of right or left eigenvectors to be
transformed, as returned by DTGEVC.
On exit, V is overwritten by the transformed eigenvectors.
.TP 8
LDV     (input) INTEGER
The leading dimension of the matrix V. LDV >= max(1,N).
.TP 8
INFO    (output) INTEGER
= 0:  successful exit.
.br
< 0:  if INFO = -i, the i-th argument had an illegal value.
.SH FURTHER DETAILS
See R.C. Ward, Balancing the generalized eigenvalue problem,
               SIAM J. Sci. Stat. Comp. 2 (1981), 141-152.
