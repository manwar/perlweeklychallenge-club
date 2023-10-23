#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Unique Sum

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers.

Write a script to find out the sum of unique elements in the given array.

=head3 Example 1:

    Input: @int = (2, 1, 3, 2)
    Output: 4

    In the given array we have 2 unique elements (1, 3).

=head3 Example 2:

    Input: @int = (1, 1, 1, 1)
    Output: 0

    In the given array no unique element found.

=head3 Example 3:

    Input: @int = (2, 1, 3, 4)
    Output: 10

    In the given array every element is unique.

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub unique-sum(Positional $_) {
    .Bag.grep(*.value ≤ 1)».key.sum
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (2, 1, 3, 2),     output => 4 },
        %{ input => (1, 1, 1, 1),     output => 0 },
        %{ input => (2, 1, 3, 4),     output => 10 },
    ];

    for @tests {
        unique-sum( .<input> ).&is-deeply: .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (Bool :$test!)


