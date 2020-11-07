#!/usr/bin/perl

use Test2::V0;
use Math::Utils 'log2';
use Math::Round;
use List::Util 'first';

# Find a pair of positive integers $m > 0, $p > 1 so that $n == $m **
# $p.  Returns the found power $p (if any).  The returned value taken as
# boolean gives the 0/1 result as requested by the task.
sub find_power {
	my $n = shift;

	# For $n = 1, $m = 1 and $p = 2 the conditions $m > 0, $p > 1 and
	# $n == $m ** $p are met.
	return 2 if $n == 1;

	# The highest possible exponent corresponds to the smallest possible
	# base, i.e. two.  Rounding (instead of truncating) is essential
	# here - at least for the root of $n.
	first {round($n**(1/$_)) ** $_ == $n} 2 .. round log2 $n;
}

is find_power(8), 3, 'Example 1';
is find_power(15), F(), 'Example 2';
is find_power(125), 3, 'Example 3';
is find_power(13**17), 17, '19 decimal places, fits into signed quad';
is find_power(1), 2, 'limiting case';

done_testing;
