#!/usr/bin/perl

use 5.012;
use warnings;

use PDL;

# Find isolated ("lonely") ones in a piddle.  Deviant from the
# challenge, numeric zeros and ones are used instead of the characters O
# and X.
#
# This is taken straight from the documentation of PDL::Threading.
# See https://metacpan.org/pod/PDL::Threading#Threaded-PDL-implementation
# for a more detailed explanation.
sub lonely_ones {
	my $m = shift;
	print $m;

	# Threaded calculation of "lonely ones".
	my $square_count = $m
		# Create 3x3 squares around each matrix element,
		# having zero values outside the valid range.
		->range(ndcoords($m) - 1, 3, 'truncate')
		# Move source dims to the front.
		->reorder(2, 3, 0, 1)
		# Sum over rows and columns.  This gives the number of ones in
		# each square.
		->sumover->sumover;

	# "Lonely ones" are cells that are occupied and that have one "one"
	# in the surrounding square.  Multiplying the test result with the
	# cell value itself gives true just for "lonely ones".  Get their
	# indices inside the matrix and convert these to an ordinary perl
	# array (of arrays).
	# Note: PDL indices are reversed.
	local $" = ',';
	say "lonely one at (@{[reverse @$_]})"
		foreach @{whichND(($square_count == 1) * $m)->unpdl};
}

# A byte suffices to store one bit.
lonely_ones(byte(
		[0, 0, 1],
		[1, 0, 0],
		[1, 0, 0]));
lonely_ones(byte(
		[0, 0, 1, 0],
		[1, 0, 0, 0],
		[1, 0, 0, 1],
		[0, 1, 0, 0]));
