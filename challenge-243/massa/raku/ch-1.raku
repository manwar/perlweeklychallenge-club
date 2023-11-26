#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Reverse Pairs

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given two arrays of integers.

Write a script to return the number of reverse pairs in the given array.

A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b)
nums[i] > 2 * nums[j].

=head3 Example 1:

    Input: @nums = (1, 3, 2, 3, 1)
    Output: 2

    (1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
    (3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1

=head3 Example 2:

    Input: @nums = (2, 4, 3, 5, 1)
    Output: 3

    (1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
    (2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
    (3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@m) {
    + @m.pairs.combinations(2).grep({.[0].value > 2 * .[1].value})».key
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  (1, 3, 2, 3, 1),
           output => (2,) },
        %{ input =>  (2, 4, 3, 5, 1),
           output => (3,) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


