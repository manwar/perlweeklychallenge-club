#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Sort Language

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given two array of languages and its popularity.

Write a script to sort the language based on popularity.

=head3 Example 1:

   Input: @lang = ('perl', 'c', 'python')
          @popularity = (2, 1, 3)
   Output: ('c', 'perl', 'python')=head3 Example 2:

=head3 Example 3:

   Input: @lang = ('c++', 'haskell', 'java')
          @popularity = (1, 3, 2)
   Output: ('c++', 'java', 'haskell')

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub SOLUTION(@ (@lang, @pop)) {
    (@pop Z=> @lang).sort(*.keys)».value
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests =
        %{ input =>  (<perl c python>, (2, 1, 3)),
           output => <c perl python> },
        %{ input =>  (<c++ haskell java>, (1, 3, 2)),
           output => <c++ java haskell> },
    ;

    .<input>.&SOLUTION.deepmap({$_}).&is-deeply: .<output>, .<text> for @tests
} # end of multi MAIN (Bool :$test!)


