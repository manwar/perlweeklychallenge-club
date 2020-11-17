#!/usr/bin/perl

# Cracking the nut with a sledgehammer:
use PDL;
use Test2::V0 '!float';

# Check if there is a pair of numbers having the given difference.
# diff is first arg, remaining args are the numbers.
sub find_diff {
	my $diff = shift;
	my $numbers = long @_;

	# Create a matrix containing all pairwise differences and BAD
	# values enabled.
	(my $diffs = $numbers - $numbers->transpose)->badflag(1);

	# Invalidate the diagonal.
	$diffs->diagonal(0, 1) .= $diffs->badvalue;

	# Check if the given difference exists.
	any($diffs == $diff);
}

is find_diff(7, 10, 8, 12, 15, 5), T(), 'Example 1';
is find_diff(6, 1, 5, 2, 9, 7), T(), 'Example 2';
is find_diff(15, 10, 30, 20, 50, 40), F(), 'Example 3';

is find_diff(0, 1, 2, 2), T(), 'zero diff exists';
is find_diff(0, 1, 2, 3), F(), 'zero diff does not exist';
is find_diff(-2, 1, 2, 4), T(), 'negative diff';

done_testing;
