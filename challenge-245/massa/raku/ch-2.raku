#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Largest of Three

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers >= 0.

Write a script to return the largest number formed by concatenating some of the
given integers in any order which is also multiple of 3. Return -1 if none
found.

=head3 Example 1:

    Input: @digits = (8, 1, 9)
    Output: 981

    981 % 3 == 0

=head3 Example 2:

    Input: @digits = (8, 6, 7, 1, 0)
    Output: 8760

=head3 Example 3:

    Input: @digits = (1)
    Output: -1

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@_) {
   @_.combinations.skip(1).map(*.permutations».join».Int).flat.sort(-*).first(* %% 3) or -1
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  (8, 1, 9),
           output => (981,) },
        %{ input =>  (8, 6, 7, 1, 0),
           output => (8760,) },
        %{ input =>  (1,),
           output => (-1,) },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


