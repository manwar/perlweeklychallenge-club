#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Three Power

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given a positive integer, $n.

Write a script to return true if the given integer is a power of three
otherwise return false.

=head3 Example 1:

   Input: $n = 27
   Output: true

   27 = 3 ^ 3

=head3 Example 2:

   Input: $n = 0
   Output: true

   0 = 0 ^ 3

=head3 Example 3:

   Input: $n = 6
   Output: false

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION($n) {
   (^∞).map(3 ** *).first(* >= $n) == $n
}

multi MAIN (Bool :$test!) {
    use Testo;

    my @tests =
        %{ input =>  27,
           output => True },
        %{ input =>  0,
           output => False },
        %{ input =>  6,
           output => False },
    ;

    .<input>.&SOLUTION.&is-eqv: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


