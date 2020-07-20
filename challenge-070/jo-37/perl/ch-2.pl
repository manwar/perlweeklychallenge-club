#!/usr/bin/perl

# Deeply impressed by E. Choroba's wonderful solution to task 1 from
# challenge 068, I realized the ease of performing linear algebra
# within PDL.  So I switched from Math::Matrix to PDL.
use PDL;
# PDL and Test2::V0 both export 'float' by default.
# Resolve the conflict:
use Test2::V0 '!float';

# As described in the (German) Wikipedia, the Gray code is a linear
# transformation (modulo 2) acting on the bit representation of its input
# value.  Let
# G = [[1, 1, 0, ..., 0, 0],
#      [0, 1, 1, ..., 0, 0],
#      ...
#      [0, 0, 0, ..., 1, 1],
#      [0, 0, 0, ..., 0, 1]]
# be a N x N matrix with all elements of the main diagonal as ones,
# all elements of the super diagonal as ones and all other elements zero.
# Then the Gray encoding of a number with bit representation b as a row
# vector of length N, is the (matrix) product b . G.

# Generate G for the given length and return a sub ref that Gray encodes
# a number. 
sub gray_encoder {
	my $len = shift;

	# Construct G.
	my $g = PDL->zeroes(byte, $len, $len);
	# Set main and super diagonal to ones.
	$g->diagonal(0, 1) .= 1;
	$g->slice('1:,:-2')->diagonal(0,1) .= 1;

	sub {
		# Create a row vector from the bits of the given number.
		my $in = pdl split //, sprintf "%0${len}b", shift;
		die "arg not valid for encoder" unless $in->dim(0) == $len;

		# Calculate the bits of the Gray encoded number.
		# Note: with PDL, the 'x' operator represents the usual matrix
		# product, not the vector cross product.
		my $out = ($in x $g) % 2;

		# Return the Gray encoded number.
		# Note: $out is not a row vector, but a 1 x N matrix
		# where the two dimensions need to be flattened into one.
		local $" = '';
		oct "0b@{unpdl $out->squeeze}";
	}
}

# One single encoder with the maximum required bit length fits for all
# smaller numbers.
my $gray = gray_encoder 5;

my $n = 4;
my @out = map $gray->($_), (0 .. 2**$n - 1);
is \@out, [0, 1, 3, 2, 6, 7, 5, 4, 12, 13, 15, 14, 10, 11, 9, 8],
	'example from challenge';

done_testing;
