#!/usr/bin/perl

use Test2::V0;
use List::Util qw(min max);

# Calculates all numbers of a given length with the given
# digit sum.
# For every possible first digit the following digits are
# retrieved by recursing into the same sub with reduced
# length and sum.
# A leading zero is allowed when the third parameter is true:
# Must not be true when called at top level,
# must be true when recursing.
sub digit_sum;
sub digit_sum {
	my ($length, $sum, $leading_zero) = @_;
	
	return if $sum > 9 * $length;
	return $sum if $length == 1;

	my $min = max !$leading_zero, $sum - 9 * ($length - 1);
	my $max = min 9, $sum;

	map {
		my $d = $_;
		map $d . $_, digit_sum $length - 1, $sum - $d, 1;
	} ($min .. $max);
}

is [digit_sum 2, 4], [13, 22, 31, 40], 'Example from challenge';
is [digit_sum 4, 3],
	[1002, 1011, 1020, 1101, 1110, 1200, 2001, 2010, 2100, 3000],
	'Another example';
is [digit_sum 2, 11],
	[29, 38, 47, 56, 65, 74, 83, 92], 'digit sum greater than 9';
is [digit_sum 1, 10], [], 'no solution';

done_testing;
