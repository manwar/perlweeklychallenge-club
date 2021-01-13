#!/usr/bin/perl

use v5.14;
use Test2::V0;

# First off: The limitation to N <= 10 kills all joy with this task.
# I'm going to ignore the restriction.
#
# Every trailing zero in any decimal number is produced by a pair of
# factors 2 and 5.  As there are many more factors 2 in a factorial
# than factors 5, the number of factors 5 give the number of
# trailing zeroes for the factorial.
# Every multiple of 5 in the product 2 * 3 * ... * n gives at least
# one such factor.  Higher powers of 5 give one additional factor.
# In summary, the number of trailing zeroes in a factorial is sum of
# the number of multiples of every power of 5 in 2 .. n.
sub fac_trailing_zeroes {
	my ($n, $tz) = (shift, 0);
	for (my $f = 5; $f <= $n; $f *= 5) {
		$tz += int $n / $f;
	}
	$tz;
}

is fac_trailing_zeroes(10), 2, 'first example';
is fac_trailing_zeroes(7), 1, 'second example';
is fac_trailing_zeroes(4), 0, 'third example';

my $tz100 = do {
	use bigint;
	length +(100 + 0)->bfac =~ s/.*?(?=0*$)//r;
};
say "100! has $tz100 trailing zeroes";
is fac_trailing_zeroes(100), $tz100, 'cross-check 100!';

say "1000000! has ", fac_trailing_zeroes(1000000), " trailing zeroes";

done_testing;
