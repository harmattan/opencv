.TH  ZHFRK 1 "November 2008" " LAPACK routine (version 3.2)                                    " " LAPACK routine (version 3.2)                                    " 
.SH NAME
ZHFRK - 3 BLAS like routine for C in RFP Format
.SH SYNOPSIS
.TP 18
SUBROUTINE ZHFRK(
TRANSR, UPLO, TRANS, N, K, ALPHA, A, LDA, BETA,
.TP 18
.ti +4
+
C )
.TP 18
.ti +4
DOUBLE
PRECISION ALPHA, BETA
.TP 18
.ti +4
INTEGER
K, LDA, N
.TP 18
.ti +4
CHARACTER
TRANS, TRANSR, UPLO
.TP 18
.ti +4
COMPLEX*16
A( LDA, * ), C( * )
.SH PURPOSE
Level 3 BLAS like routine for C in RFP Format.
ZHFRK performs one of the Hermitian rank--k operations
.br
   C := alpha*A*conjg( A\(aq ) + beta*C,
.br
or
.br
   C := alpha*conjg( A\(aq )*A + beta*C,
.br
where alpha and beta are real scalars, C is an n--by--n Hermitian
matrix and A is an n--by--k matrix in the first case and a k--by--n
matrix in the second case.
.br
.SH ARGUMENTS
.TP 10
TRANSR    (input) CHARACTER.
= \(aqN\(aq:  The Normal Form of RFP A is stored;
.br
= \(aqC\(aq:  The Conjugate-transpose Form of RFP A is stored.
.TP 7
UPLO   - (input) CHARACTER.
On  entry,   UPLO  specifies  whether  the  upper  or  lower
triangular  part  of the  array  C  is to be  referenced  as
follows:
UPLO = \(aqU\(aq or \(aqu\(aq   Only the  upper triangular part of  C
is to be referenced.
UPLO = \(aqL\(aq or \(aql\(aq   Only the  lower triangular part of  C
is to be referenced.
Unchanged on exit.
.TP 7
TRANS  - (input) CHARACTER.
On entry,  TRANS  specifies the operation to be performed as
follows:
TRANS = \(aqN\(aq or \(aqn\(aq   C := alpha*A*conjg( A\(aq ) + beta*C.
TRANS = \(aqC\(aq or \(aqc\(aq   C := alpha*conjg( A\(aq )*A + beta*C.
Unchanged on exit.
.TP 7
N      - (input) INTEGER.
On entry,  N specifies the order of the matrix C.  N must be
at least zero.
Unchanged on exit.
.TP 7
K      - (input) INTEGER.
On entry with  TRANS = \(aqN\(aq or \(aqn\(aq,  K  specifies  the number
of  columns   of  the   matrix   A,   and  on   entry   with
TRANS = \(aqC\(aq or \(aqc\(aq,  K  specifies  the number of rows of the
matrix A.  K must be at least zero.
Unchanged on exit.
.TP 7
ALPHA  - (input) DOUBLE PRECISION.
On entry, ALPHA specifies the scalar alpha.
Unchanged on exit.
.TP 7
A      - (input) COMPLEX*16 array of DIMENSION ( LDA, ka ), where KA
is K  when TRANS = \(aqN\(aq or \(aqn\(aq, and is N otherwise. Before
entry with TRANS = \(aqN\(aq or \(aqn\(aq, the leading N--by--K part of
the array A must contain the matrix A, otherwise the leading
K--by--N part of the array A must contain the matrix A.
Unchanged on exit.
.TP 7
LDA    - (input) INTEGER.
On entry, LDA specifies the first dimension of A as declared
in  the  calling  (sub)  program.   When  TRANS = \(aqN\(aq or \(aqn\(aq
then  LDA must be at least  max( 1, n ), otherwise  LDA must
be at least  max( 1, k ).
Unchanged on exit.
.TP 7
BETA   - (input) DOUBLE PRECISION.
On entry, BETA specifies the scalar beta.
Unchanged on exit.
.TP 7
C      - (input/output) COMPLEX*16 array, dimension ( N*(N+1)/2 ).
On entry, the matrix A in RFP Format. RFP Format is
described by TRANSR, UPLO and N. Note that the imaginary
parts of the diagonal elements need not be set, they are
assumed to be zero, and on exit they are set to zero.
.SH ARGUMENTS
..
