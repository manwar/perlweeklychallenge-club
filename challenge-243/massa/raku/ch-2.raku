#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Floor Sum

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of positive integers (>=1).

Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j <
nums.length. The floor() function returns the integer part of the division.

=head3 Example 1:

    Input: @nums = (2, 5, 9)
    Output: 10

    floor(2 / 5) = 0
    floor(2 / 9) = 0
    floor(5 / 9) = 0
    floor(2 / 2) = 1
    floor(5 / 5) = 1
    floor(9 / 9) = 1
    floor(5 / 2) = 2
    floor(9 / 2) = 4
    floor(9 / 5) = 1

=head3 Example 2:

    Input: @nums = (7, 7, 7, 7, 7, 7, 7)
    Output: 49

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@_) {
    [+] @_ Xdiv @_
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  (2, 5, 9),
           output => (10,) },
        %{ input =>  (7, 7, 7, 7, 7, 7, 7),
           output => (49,) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


