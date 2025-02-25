#!/usr/bin/env perl
use v5.40;

use Test::More;

=head1 Perl Weekly Challenge 301 Task 1

You are given a list of positive integers, @ints.

Write a script to arrange all the elements in the given list such that they form the largest number and return it.
Example 1

Input: @ints = (20, 3)
Output: 320

Example 2

Input: @ints = (3, 30, 34, 5, 9)
Output: 9534330

=head2 Perl functions/sort

Use of the sort compare operator <=> to achieve the desired  result.

=cut

sub largest_number(@ints) {
    my @sorted = sort { ($b . $a) <=> ($a . $b) } @ints;
    return join('',@sorted);
}

is( largest_number(20, 3), 320, "Example 1");
is( largest_number(3, 30, 34, 5, 9), 9534330, "Example 2");

done_testing;
