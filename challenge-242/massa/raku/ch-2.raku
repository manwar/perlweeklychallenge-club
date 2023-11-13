#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Flip Matrix

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given n x n binary matrix.

Write a script to flip the given matrix as below.

    1 1 0
    0 1 1
    0 0 1

    a) Reverse each row

    0 1 1
    1 1 0
    1 0 0

    b) Invert each member

    1 0 0
    0 0 1
    0 1 1

=head3 Example 1:

    Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
    Output:          ([1, 0, 0], [0, 1, 0], [1, 1, 1])

=head3 Example 2:

    Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
    Output:          ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@_) {
    @_».reverse».map: 1 - *
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  ((1, 1, 0), (1, 0, 1), (0, 0, 0)),
           output => ((1, 0, 0), (0, 1, 0), (1, 1, 1)) },
        %{ input =>  ((1, 1, 0, 0), (1, 0, 0, 1), (0, 1, 1, 1), (1, 0, 1, 0)),
           output => ((1, 1, 0, 0), (0, 1, 1, 0), (0, 0, 0, 1), (1, 0, 1, 0)) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


