.TH  DLARF 1 "November 2008" " LAPACK auxiliary routine (version 3.2) " " LAPACK auxiliary routine (version 3.2) " 
.SH NAME
DLARF - applies a real elementary reflector H to a real m by n matrix C, from either the left or the right
.SH SYNOPSIS
.TP 18
SUBROUTINE DLARF(
SIDE, M, N, V, INCV, TAU, C, LDC, WORK )
.TP 18
.ti +4
IMPLICIT
NONE
.TP 18
.ti +4
CHARACTER
SIDE
.TP 18
.ti +4
INTEGER
INCV, LDC, M, N
.TP 18
.ti +4
DOUBLE
PRECISION TAU
.TP 18
.ti +4
DOUBLE
PRECISION C( LDC, * ), V( * ), WORK( * )
.SH PURPOSE
DLARF applies a real elementary reflector H to a real m by n matrix
C, from either the left or the right. H is represented in the form
      H = I - tau * v * v\(aq
.br
where tau is a real scalar and v is a real vector.
.br
If tau = 0, then H is taken to be the unit matrix.
.br
.SH ARGUMENTS
.TP 8
SIDE    (input) CHARACTER*1
= \(aqL\(aq: form  H * C
.br
= \(aqR\(aq: form  C * H
.TP 8
M       (input) INTEGER
The number of rows of the matrix C.
.TP 8
N       (input) INTEGER
The number of columns of the matrix C.
.TP 8
V       (input) DOUBLE PRECISION array, dimension
(1 + (M-1)*abs(INCV)) if SIDE = \(aqL\(aq
or (1 + (N-1)*abs(INCV)) if SIDE = \(aqR\(aq
The vector v in the representation of H. V is not used if
TAU = 0.
.TP 8
INCV    (input) INTEGER
The increment between elements of v. INCV <> 0.
.TP 8
TAU     (input) DOUBLE PRECISION
The value tau in the representation of H.
.TP 8
C       (input/output) DOUBLE PRECISION array, dimension (LDC,N)
On entry, the m by n matrix C.
On exit, C is overwritten by the matrix H * C if SIDE = \(aqL\(aq,
or C * H if SIDE = \(aqR\(aq.
.TP 8
LDC     (input) INTEGER
The leading dimension of the array C. LDC >= max(1,M).
.TP 8
WORK    (workspace) DOUBLE PRECISION array, dimension
(N) if SIDE = \(aqL\(aq
or (M) if SIDE = \(aqR\(aq
