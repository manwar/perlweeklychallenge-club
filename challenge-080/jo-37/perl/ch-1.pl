#!/usr/bin/perl

use Test2::V0;

# Find the smallest positive number not in given set.
sub missing_number {

	# Find the first gap within the sorted positive numbers and zero.
	my $prev = 0;
	foreach (sort {$a <=> $b} grep $_ > 0, @_) {
		last if $_ - $prev > 1;
		$prev = $_;
	}

	# Successor is the smallest number missing in set.
	$prev + 1;
}
is missing_number(5, 2, -2, 0), 1, 'first example';
is missing_number(1, 8, -1), 2, 'second example';
is missing_number(2, 0, -1), 1, 'third example';
is missing_number(-1, 1, 2, 3), 4, 'no gap in set';

done_testing;
