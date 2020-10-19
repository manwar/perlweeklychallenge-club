#!/usr/bin/perl

use Test2::V0;
use Math::Utils 'gcd';

# Find all common divisors of $m and $n.
# Any common divisor must be a divisor of the greatest common divisor of
# the given numbers, too.  There is no limitation to two numbers only.
sub common_divisors {
	my $gcd = gcd @_;

	# - Prepend one, as it is always a common divisor.
	# - Test all numbers between 2 and sqrt($gcd) as divisors of $gcd.
	#   If a detected divisor is the square root of $gcd, this gives one
	#   element in the result set and a pair of elements otherwise.  The
	#   result set is sorted for clarity.
	# - Append $gcd if it is larger than one.
	(
		1,
		(sort {$a <=> $b} map {
				my $d = int $gcd / $_;
				$_ * $d == $gcd ? $_ == $d ? ($_) : ($_, $d) : ();
			} 2 .. sqrt $gcd),
		($gcd) x !!($gcd - 1)
	);

}

is [common_divisors 12, 18], [1, 2, 3, 6], 'first example';
is [common_divisors 18, 23], [1], 'second example';
is [common_divisors 21, 35], [1, 7], 'another example';
is [common_divisors 2*3*7*11, 2*3*5*11, 2*3*5*7],
	[1, 2, 3, 6], 'more than two given numbers';
is [common_divisors 45, 63], [1, 3, 9], 'square gcd';

done_testing;
