#!/usr/bin/perl

use integer;
use Test2::V0;

# Implement Ethiopian multiplication
sub ethiopian_mult {
	my ($p, $q) = splice @_, 0, 2;
	# The method is more effective if the first number is the smaller
	# one.
	($p, $q) = ($q, $p) if $p > $q;

	my $prod = 0;
	while ($p) {
		# Add second number if the first is odd
		$prod += ($p % 2) * $q;
		# Get next pair.
		($p, $q) = ($p / 2, $q * 2);
	}

	$prod;
}

is ethiopian_mult(14, 12), 168, 'Example 1';
is ethiopian_mult(2**32, 0), 0, 'Multiply by zero';
is ethiopian_mult(2**32, 1), 2**32, 'Multiply by one';

done_testing;
