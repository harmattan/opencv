.TH  STFTRI 1 "November 2008" " LAPACK routine (version 3.2)                                    " " LAPACK routine (version 3.2)                                    " 
.SH NAME
STFTRI - computes the inverse of a triangular matrix A stored in RFP format
.SH SYNOPSIS
.TP 19
SUBROUTINE STFTRI(
TRANSR, UPLO, DIAG, N, A, INFO )
.TP 19
.ti +4
CHARACTER
TRANSR, UPLO, DIAG
.TP 19
.ti +4
INTEGER
INFO, N
.TP 19
.ti +4
REAL
A( 0: * )
.SH PURPOSE
STFTRI computes the inverse of a triangular matrix A stored in RFP
format.
This is a Level 3 BLAS version of the algorithm.
.br
.SH ARGUMENTS
.TP 10
TRANSR    (input) CHARACTER
= \(aqN\(aq:  The Normal TRANSR of RFP A is stored;
.br
= \(aqT\(aq:  The Transpose TRANSR of RFP A is stored.
.TP 8
UPLO    (input) CHARACTER
.br
= \(aqU\(aq:  A is upper triangular;
.br
= \(aqL\(aq:  A is lower triangular.
.TP 8
DIAG    (input) CHARACTER
.br
= \(aqN\(aq:  A is non-unit triangular;
.br
= \(aqU\(aq:  A is unit triangular.
.TP 8
N       (input) INTEGER
The order of the matrix A.  N >= 0.
.TP 8
A       (input/output) REAL array, dimension (NT);
NT=N*(N+1)/2. On entry, the triangular factor of a Hermitian
Positive Definite matrix A in RFP format. RFP format is
described by TRANSR, UPLO, and N as follows: If TRANSR = \(aqN\(aq
.br
then RFP A is (0:N,0:k-1) when N is even; k=N/2. RFP A is
.br
(0:N-1,0:k) when N is odd; k=N/2. IF TRANSR = \(aqT\(aq then RFP is
the transpose of RFP A as defined when
TRANSR = \(aqN\(aq. The contents of RFP A are defined by UPLO as
follows: If UPLO = \(aqU\(aq the RFP A contains the nt elements of
upper packed A; If UPLO = \(aqL\(aq the RFP A contains the nt
elements of lower packed A. The LDA of RFP A is (N+1)/2 when
TRANSR = \(aqT\(aq. When TRANSR is \(aqN\(aq the LDA is N+1 when N is
even and N is odd. See the Note below for more details.
On exit, the (triangular) inverse of the original matrix, in
the same storage format.
.TP 8
INFO    (output) INTEGER
= 0: successful exit
.br
< 0: if INFO = -i, the i-th argument had an illegal value
.br
> 0: if INFO = i, A(i,i) is exactly zero.  The triangular
matrix is singular and its inverse can not be computed.
.SH FURTHER DETAILS
We first consider Rectangular Full Packed (RFP) Format when N is
even. We give an example where N = 6.
.br
    AP is Upper             AP is Lower
.br
 00 01 02 03 04 05       00
.br
    11 12 13 14 15       10 11
.br
       22 23 24 25       20 21 22
.br
          33 34 35       30 31 32 33
.br
             44 45       40 41 42 43 44
.br
                55       50 51 52 53 54 55
.br
Let TRANSR = \(aqN\(aq. RFP holds AP as follows:
.br
For UPLO = \(aqU\(aq the upper trapezoid A(0:5,0:2) consists of the last
three columns of AP upper. The lower triangle A(4:6,0:2) consists of
the transpose of the first three columns of AP upper.
.br
For UPLO = \(aqL\(aq the lower trapezoid A(1:6,0:2) consists of the first
three columns of AP lower. The upper triangle A(0:2,0:2) consists of
the transpose of the last three columns of AP lower.
.br
This covers the case N even and TRANSR = \(aqN\(aq.
.br
       RFP A                   RFP A
.br
      03 04 05                33 43 53
.br
      13 14 15                00 44 54
.br
      23 24 25                10 11 55
.br
      33 34 35                20 21 22
.br
      00 44 45                30 31 32
.br
      01 11 55                40 41 42
.br
      02 12 22                50 51 52
.br
Now let TRANSR = \(aqT\(aq. RFP A in both UPLO cases is just the
transpose of RFP A above. One therefore gets:
.br
         RFP A                   RFP A
.br
   03 13 23 33 00 01 02    33 00 10 20 30 40 50
.br
   04 14 24 34 44 11 12    43 44 11 21 31 41 51
.br
   05 15 25 35 45 55 22    53 54 55 22 32 42 52
.br
We first consider Rectangular Full Packed (RFP) Format when N is
odd. We give an example where N = 5.
.br
   AP is Upper                 AP is Lower
.br
 00 01 02 03 04              00
.br
    11 12 13 14              10 11
.br
       22 23 24              20 21 22
.br
          33 34              30 31 32 33
.br
             44              40 41 42 43 44
.br
Let TRANSR = \(aqN\(aq. RFP holds AP as follows:
.br
For UPLO = \(aqU\(aq the upper trapezoid A(0:4,0:2) consists of the last
three columns of AP upper. The lower triangle A(3:4,0:1) consists of
the transpose of the first two columns of AP upper.
.br
For UPLO = \(aqL\(aq the lower trapezoid A(0:4,0:2) consists of the first
three columns of AP lower. The upper triangle A(0:1,1:2) consists of
the transpose of the last two columns of AP lower.
.br
This covers the case N odd and TRANSR = \(aqN\(aq.
.br
       RFP A                   RFP A
.br
      02 03 04                00 33 43
.br
      12 13 14                10 11 44
.br
      22 23 24                20 21 22
.br
      00 33 34                30 31 32
.br
      01 11 44                40 41 42
.br
Now let TRANSR = \(aqT\(aq. RFP A in both UPLO cases is just the
transpose of RFP A above. One therefore gets:
.br
         RFP A                   RFP A
.br
   02 12 22 00 01             00 10 20 30 40 50
.br
   03 13 23 33 11             33 11 21 31 41 51
.br
   04 14 24 34 44             43 44 22 32 42 52
.br
