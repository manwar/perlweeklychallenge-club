#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Count Smaller

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers.

Write a script to calculate the number of integers smaller than the integer at
each index.

=head3 Example 1:

    Input: @int = (8, 1, 2, 2, 3)
    Output: (4, 0, 1, 1, 3)

    For index = 0, count of elements less 8 is 4.
    For index = 1, count of elements less 1 is 0.
    For index = 2, count of elements less 2 is 1.
    For index = 3, count of elements less 2 is 1.
    For index = 4, count of elements less 3 is 3.

=head3 Example 2:

    Input: @int = (6, 5, 4, 8)
    Output: (2, 1, 0, 3)

=head3 Example 3:

    Input: @int = (2, 2, 2)
    Output: (0, 0, 0)

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@a) {
    (@a X> @a)».Int.batch(+@a).map(*.sum)
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  (8, 1, 2, 2, 3),
           output => (4, 0, 1, 1, 3) },
        %{ input =>  (6, 5, 4, 8),
           output => (2, 1, 0, 3) },
        %{ input =>  (2, 2, 2),
           output => (0, 0, 0) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


