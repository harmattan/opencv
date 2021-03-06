.TH  ZLANHP 1 "November 2008" " LAPACK auxiliary routine (version 3.2) " " LAPACK auxiliary routine (version 3.2) " 
.SH NAME
ZLANHP - returns the value of the one norm, or the Frobenius norm, or the infinity norm, or the element of largest absolute value of a complex hermitian matrix A, supplied in packed form
.SH SYNOPSIS
.TP 17
DOUBLE PRECISION
FUNCTION ZLANHP( NORM, UPLO, N, AP, WORK )
.TP 17
.ti +4
CHARACTER
NORM, UPLO
.TP 17
.ti +4
INTEGER
N
.TP 17
.ti +4
DOUBLE
PRECISION WORK( * )
.TP 17
.ti +4
COMPLEX*16
AP( * )
.SH PURPOSE
ZLANHP  returns the value of the one norm,  or the Frobenius norm, or
the  infinity norm,  or the  element of  largest absolute value  of a
complex hermitian matrix A,  supplied in packed form.
.SH DESCRIPTION
ZLANHP returns the value
.br
   ZLANHP = ( max(abs(A(i,j))), NORM = \(aqM\(aq or \(aqm\(aq
.br
            (
.br
            ( norm1(A),         NORM = \(aq1\(aq, \(aqO\(aq or \(aqo\(aq
.br
            (
.br
            ( normI(A),         NORM = \(aqI\(aq or \(aqi\(aq
.br
            (
.br
            ( normF(A),         NORM = \(aqF\(aq, \(aqf\(aq, \(aqE\(aq or \(aqe\(aq
where  norm1  denotes the  one norm of a matrix (maximum column sum),
normI  denotes the  infinity norm  of a matrix  (maximum row sum) and
normF  denotes the  Frobenius norm of a matrix (square root of sum of
squares).  Note that  max(abs(A(i,j)))  is not a consistent matrix norm.
.SH ARGUMENTS
.TP 8
NORM    (input) CHARACTER*1
Specifies the value to be returned in ZLANHP as described
above.
.TP 8
UPLO    (input) CHARACTER*1
Specifies whether the upper or lower triangular part of the
hermitian matrix A is supplied.
= \(aqU\(aq:  Upper triangular part of A is supplied
.br
= \(aqL\(aq:  Lower triangular part of A is supplied
.TP 8
N       (input) INTEGER
The order of the matrix A.  N >= 0.  When N = 0, ZLANHP is
set to zero.
.TP 8
AP      (input) COMPLEX*16 array, dimension (N*(N+1)/2)
The upper or lower triangle of the hermitian matrix A, packed
columnwise in a linear array.  The j-th column of A is stored
in the array AP as follows:
if UPLO = \(aqU\(aq, AP(i + (j-1)*j/2) = A(i,j) for 1<=i<=j;
if UPLO = \(aqL\(aq, AP(i + (j-1)*(2n-j)/2) = A(i,j) for j<=i<=n.
Note that the  imaginary parts of the diagonal elements need
not be set and are assumed to be zero.
.TP 8
WORK    (workspace) DOUBLE PRECISION array, dimension (MAX(1,LWORK)),
where LWORK >= N when NORM = \(aqI\(aq or \(aq1\(aq or \(aqO\(aq; otherwise,
WORK is not referenced.
