#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Group Hero

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers representing the strength.

Write a script to return the sum of the powers of all possible combinations;
power is defined as the square of the largest number in a sequence, multiplied
by the smallest.


=head3 Example 1:

    Input: @nums = (2, 1, 4)
    Output: 141

    Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
    Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
    Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
    Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
    Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
    Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
    Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16

    Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@_) {
    [+] @_.combinations.grep(+ *).map: { .max² * .min }
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  (2, 1, 4),
           output => (141,) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


