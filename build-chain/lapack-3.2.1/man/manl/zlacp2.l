.TH  ZLACP2 1 "November 2008" " LAPACK auxiliary routine (version 3.2) " " LAPACK auxiliary routine (version 3.2) " 
.SH NAME
ZLACP2 - copies all or part of a real two-dimensional matrix A to a complex matrix B
.SH SYNOPSIS
.TP 19
SUBROUTINE ZLACP2(
UPLO, M, N, A, LDA, B, LDB )
.TP 19
.ti +4
CHARACTER
UPLO
.TP 19
.ti +4
INTEGER
LDA, LDB, M, N
.TP 19
.ti +4
DOUBLE
PRECISION A( LDA, * )
.TP 19
.ti +4
COMPLEX*16
B( LDB, * )
.SH PURPOSE
ZLACP2 copies all or part of a real two-dimensional matrix A to a
complex matrix B.
.SH ARGUMENTS
.TP 8
UPLO    (input) CHARACTER*1
Specifies the part of the matrix A to be copied to B.
= \(aqU\(aq:      Upper triangular part
.br
= \(aqL\(aq:      Lower triangular part
.br
Otherwise:  All of the matrix A
.TP 8
M       (input) INTEGER
The number of rows of the matrix A.  M >= 0.
.TP 8
N       (input) INTEGER
The number of columns of the matrix A.  N >= 0.
.TP 8
A       (input) DOUBLE PRECISION array, dimension (LDA,N)
The m by n matrix A.  If UPLO = \(aqU\(aq, only the upper trapezium
is accessed; if UPLO = \(aqL\(aq, only the lower trapezium is
accessed.
.TP 8
LDA     (input) INTEGER
The leading dimension of the array A.  LDA >= max(1,M).
.TP 8
B       (output) COMPLEX*16 array, dimension (LDB,N)
On exit, B = A in the locations specified by UPLO.
.TP 8
LDB     (input) INTEGER
The leading dimension of the array B.  LDB >= max(1,M).
