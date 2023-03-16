#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

	Week 208:


	Task 2: Duplicate and Missing
	Submitted by: Mohammad S Anwar
	You are given an array of integers in sequence with one missing and one duplicate.

	Write a script to find the duplicate and missing integer in the given array. Return -1 if none found.

	For the sake of this task, let us assume the array contains no more than one duplicate and missing.

	Example 1:

	Input: @nums = (1,2,2,4)
	Output: (2,3)

	Duplicate is 2 and Missing is 3.
	Example 2:

	Input: @nums = (1,2,3,4)
	Output: -1

	No duplicate and missing found.
	Example 3:

	Input: @nums = (1,2,3,3)
	Output: (3,4)

	Duplicate is 3 and Missing is 4.

=cut


is(GetDuplicateAndMissing(1, 2, 2, 4), [2, 3], 'Test Case 1.');
is(GetDuplicateAndMissing(1, 2, 3, 4), [-1], 'Test Case 2.');
is(GetDuplicateAndMissing(1, 2, 3, 3), [3, 4], 'Test Case 3.');

sub GetDuplicateAndMissing {
	my @sequence = @_;

	my @missing_and_duplicate = (-1);
	my $sequence_size = scalar(@sequence);

	foreach my $index (1..$sequence_size - 1) {
		if ($sequence[$index - 1] == $sequence[$index]) {
			@missing_and_duplicate = ($sequence[$index], $sequence[$index] + 1);
			last;
		}
	}

	return \@missing_and_duplicate;
}

done_testing();
