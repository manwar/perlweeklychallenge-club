#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Target index

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers, `@ints` and a target element `$k`.

Write a script to return the list of indices in the sorted array where
the element is same as the given target element.

=head3 Example 1:

    Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
    Output: (1, 2)

=head3 Example 2:

    Input: @ints = (1, 2, 4, 3, 5), $k = 6
    Output: ()

=head3 Example 3:

    Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
    Output: (4)

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(\k, +a) {
  a.sort.grep: * == k, :k
}

multi MAIN (Bool :$test!) {
    use Testo;

    my @tests =
        %{ input =>  (2, (1, 5, 3, 2, 4, 2)),
           output => (1, 2) },
        %{ input =>  (6, (1, 2, 4, 3, 5)),
           output => () },
        %{ input =>  (4, (5, 3, 2, 4, 2, 1)),
           output => (4,) },
    ;

    SOLUTION(|.<input>).&is: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


