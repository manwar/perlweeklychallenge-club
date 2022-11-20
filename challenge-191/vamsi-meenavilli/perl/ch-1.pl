#!/usr/bin/perl

=head1

Week 191:
    https://theweeklychallenge.org/blog/perl-weekly-challenge-191

    Task 1: Twice Largest You are given list of integers, @list. Write a script to find out whether the largest item in
    the list is at least twice as large as each of the other items.

=cut

use Test2::V0;

is doesTwiceLargestNumberExists(1, 2, 3, 4), -1, 'Example 1';
is doesTwiceLargestNumberExists(1, 2, 0, 5), 1, 'Example 2';
is doesTwiceLargestNumberExists(2, 6, 3, 1), -1, 'Example 3';
is doesTwiceLargestNumberExists(4, 5, 2, 3), -1, 'Example 4';

sub doesTwiceLargestNumberExists {
	my (@number_array) = @_;

	@number_array = sort @number_array;

	return ($number_array[-1] >= $number_array[-2]**2) ? 1 : -1;
}

done_testing();
