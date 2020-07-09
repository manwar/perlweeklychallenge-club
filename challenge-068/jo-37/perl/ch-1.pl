#!/usr/bin/perl

use strict;
use warnings;
use Math::Matrix;

# let:
# A . B the matrix product of A and B
# M  be a R x C matrix
# r1 an all-1 column vector of size C
# l1 an all-1 row vector of size R
# RS a diagonal matrix of size R x R. Elements in the diagonal are zero
#    or one and act as a row selector for a matrix M1 having R rows
#    by multiplying RS . M
# CS a diagonal matrix of size C x C. Elements in the diagonal are zero
#    or one and act as a column selector for a matrix M2 having C
#    columns by multiplying M . CS
#
# The matrix product M . r1 gives the row sums of M.  For a matrix of
# only zeros and ones a row sum equals C if and only if all elements of
# the row are ones.
# Analogous, the matrix product l1 . M gives the column sums of M and
# here a column sum of R indicates all-one in the corresponding column.
#
# The selector matrices can be constructed from the row sums and
# column sums of M by mapping the sums to zero or one as described.
# Let Rsel(c) and Csel(r) be the corresponding selector matrices for
# given row and columns sum vectors.
#
# The requested matrix from the challenge then can be written as:
# RSel(M . r1) . M . CSel(l1 . M)

sub zero_matrix {
	my $m = shift;
	my ($rows, $cols) = $m->size;

	Math::Matrix->diagonal(map $_->[0] == $cols,
		@{$m->multiply(Math::Matrix->new([(1) x $cols])->transpose)})->
	multiply($m)->
	multiply(Math::Matrix->diagonal(map $_ == $rows,
			@{Math::Matrix->new([(1) x $rows])->multiply($m)->[0]}));
}

my $m1 = Math::Matrix->new([1, 0, 1], [1, 1, 1], [1, 1, 1]);
$m1->print("M1:\n");
my $z1 = zero_matrix $m1;
$z1->print("Z1:\n");

my $m2 = Math::Matrix->new([1, 0, 1], [1, 1, 1], [1, 0, 1]);
$m2->print("M2:\n");
my $z2 = zero_matrix $m2;
$z2->print("Z2:\n");

my $m3 = Math::Matrix->new([1, 0, 1], [1, 1, 1], [1, 1, 1], [1, 1, 0]);
$m3->print("M3:\n");
my $z3 = zero_matrix $m3;
$z3->print("Z3:\n");
