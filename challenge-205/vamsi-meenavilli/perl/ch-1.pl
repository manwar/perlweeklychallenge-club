#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

use List::MoreUtils qw(uniq);
use Test2::V0;

=head1 AUTHORS

Vamsi Meenavilli

=head1 DESCRIPTION

	Week 205:

	https://theweeklychallenge.org/blog/perl-weekly-challenge-205

	Task 1: Third Highest
	Submitted by: Mohammad S Anwar
	You are given an array of integers.

	Write a script to find out the Third Highest if found otherwise return the maximum.

	Example 1
	Input: @array = (5,3,4)
	Output: 3

	First highest is 5. Second highest is 4. Third highest is 3.
	Example 2
	Input: @array = (5,6)
	Output: 6

	First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.
	Example 3
	Input: @array = (5,4,4,3)
	Output: 3

	First highest is 5. Second highest is 4. Third highest is 3.

=cut


is(ThirdHighestOrMax(5,3,4), 3, 'Test Case 1.');
is(ThirdHighestOrMax(5,6), 6, 'Test Case 2.');
is(ThirdHighestOrMax(5,4,4,3), 3, 'Test Case 3.');

sub ThirdHighestOrMax {
	my @array = @_;

	my @sorted_array = sort { $b <=> $a } uniq(@array);

	return scalar @sorted_array > 2 ? $sorted_array[2] : $sorted_array[0];
}

done_testing();
