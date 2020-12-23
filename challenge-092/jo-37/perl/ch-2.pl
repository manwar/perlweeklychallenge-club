#!/usr/bin/perl

use v5.16;
use Test2::V0;
use experimental 'postderef';
use List::MoreUtils 'minmax';

# Intervals are represented here by refs to two-element arrays
# containing the lower and upper border.  At least one border (the same
# side for all) has to be part of the interval.

# Single insertion step: return the interval(s) to be passed to the
# result and the new insertion (if any) when comparing the insertion
# with a single part of the given interval list.
sub pass_merge {
	my ($base, $insert) = @_;

	# No insertion: just pass the base.
	return [$base] unless $insert;

	# Base below insertion: pass the base and keep the insertion.
	return ([$base], $insert) if $base->[1] < $insert->[0];

	# Insertion below base: pass insertion and base, clear insertion.
	return [$insert, $base] if $insert->[1] < $base->[0];

	# Overlapping intervals: pass nothing and use merged intervals as
	# new insertion.
	([], [minmax $base->@*, $insert->@*]);
}

# Insert the new interval (1st arg) into the list of given intervals by
# sliding the insertion over the list of intervals and performing the
# operations as provided by pass_merge.
sub insert {
	my $insert = shift;

	((map {
			(my $pass, $insert) = pass_merge $_, $insert;
			$pass->@*;
			} @_),
		# Append the insertion if it still exists.
		($insert) x !!$insert);
}

is [insert [2, 6], [1, 4], [8, 10]],
	[[1, 6], [8, 10]], 'Example 1';

is [insert [5, 8], [1, 2], [3, 7], [8, 10]],
	[[1, 2], [3, 10]], 'Example 2';

is [insert [10, 11], [1, 5], [7, 9]],
	[[1, 5], [7, 9], [10, 11]], 'Example 3';

is [insert [1, 2], [3, 4], [5, 6], [7, 8]],
	[[1, 2], [3, 4], [5, 6], [7, 8]], 'Prepend new interval';

is [insert [9, 10], [3, 4], [5, 6], [7, 8]],
	[[3, 4], [5, 6], [7, 8], [9, 10]], 'Append new interval';

is [insert [1, 8], [2, 3], [4, 5], [6, 7]],
	[[1, 8]], 'Eat up everything';

is [insert [3, 5], [1, 2], [4, 6], [7, 8], [9, 10]],
	[[1, 2], [3, 6], [7, 8], [9, 10]], 'Left merge';

is [insert [4, 6], [1, 2], [3, 5], [7, 8], [9, 10]],
	[[1, 2], [3, 6], [7, 8], [9, 10]], 'Right merge';

is [insert [5, 8], [1, 2], [4, 6], [7, 9], [10, 11], [12, 13]],
	[[1, 2], [4, 9], [10, 11], [12, 13]], 'Join intervals'; 

done_testing;
