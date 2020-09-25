#!/usr/bin/perl

use Test2::V0;
no warnings 'recursion';
use bigint;
use Memoize;
use constant MOD => 1000000007;

memoize 'bitsum';

# Calculate the sum of 1-bits in all numbers from 0 to n.  Going from 0
# to n instead of 1 to n does not change the result, but simplifies the
# calculation.
sub bitsum {
	my $n = shift;

	# Break recursion.
	return 0 unless $n;

	# Get the largest number of the form 2^k - 1 that is (strictly) less
	# than n.
	my $allone = 2**(($n + 0)->blog(2)) - 1;

	# Get the offset from the above number to n.
	my $offset = $n - $allone;

	# Split the numbers from 0 to n into two parts:
	# - a maximum power-of-two block having zero as the highest bit.
	#   Recursing into this part to get the bit sum.
	# - a remaining block having one as the highest bit.  These leading
	#   bits are added to the bit sum.  The bit-sum of the second part
	#   with the leading bit set to zero is calculated by recursion.
	# When splitting a full power-of-two part, both sub-parts to be
	# recursed into are the same.  This leads to a shortcut for at least
	# half of the calculations.
	$offset + ($allone == $offset - 1 ?
		2 * bitsum($allone) :
		bitsum($allone) + bitsum($offset - 1));
}

# Apply the modulus.
sub bitsum_mod {
	bitsum(shift) % MOD;
}

is bitsum_mod(4), 5, 'first example';
is bitsum_mod(3), 4, 'second example';
is bitsum_mod(77347884), 1, 'silver bullet';

done_testing;
