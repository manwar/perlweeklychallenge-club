#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Split Strings

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of strings and a character separator.

Write a script to return all words separated by the given character excluding
empty string.

=head3 Example 1:

   Input: @words = ("one.two.three","four.five","six")
          $separator = "."
   Output: "one","two","three","four","five","six"

=head3 Example 2:

   Input: @words = ("$perl$$", "$$raku$")
          $separator = "$"
   Output: "perl","raku"

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION($sep, @_) {
   @_.map(*.split($sep, :skip-empty).Slip)
}

multi MAIN (Bool :$test!) {
    use Testo;

    my @tests =
        %{ input =>  \( '.', ( 'one.two.three', 'four.five', 'six' ) ),
           output => ( "one","two","three","four","five","six" ) },
        %{ input =>  \( '$', ( '$perl$$', '$$raku$' ) ),
           output =>  ( 'perl', 'raku' ) },
    ;

    SOLUTION(|.<input>).&is: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


