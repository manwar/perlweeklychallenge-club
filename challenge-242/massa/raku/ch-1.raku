#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Missing Members

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given two arrays of integers.

Write a script to find out the missing members in each other arrays.

=head3 Example 1:

    Input: @arr1 = (1, 2, 3)
           @arr2 = (2, 4, 6)
    Output: ([1, 3], [4, 6])

    (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
    (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).

=head3 Example 2:

    Input: @arr1 = (1, 2, 3, 3)
           @arr2 = (1, 1, 2, 2)
    Output: ([3])

    (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
    (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@ (@a, @b)) {
    (@a ∖ @b, @b ∖ @a)».keys».sort
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  ((1, 2, 3), (2, 4, 6)),
           output => ((1, 3), (4, 6)) },
        %{ input =>  ((1, 2, 3, 3), (1, 1, 2, 2)),
           output => ((3,), ()) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


