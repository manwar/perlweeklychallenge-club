#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Consistent Strings

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of strings and allowed string having distinct
characters.

A string is consistent if all characters in the string appear in the string
allowed.

Write a script to return the number of consistent strings in the given array.

=head3 Example 1:

Input: @str = ("ad", "bd", "aaab", "baa", "badab")
       $allowed = "ab"
Output: 2

Strings "aaab" and "baa" are consistent since they only contain characters 'a'
and 'b'.

=head3 Example 2:

Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
       $allowed = "abc"
Output: 7

Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.

=head3 Example 3:

Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
       $allowed = "cad"
Output: 4

Strings "cc", "acd", "ac", and "d" are consistent.

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub consistent-strings(@_, $allowed) {
  my @allowed = $allowed.comb;
  @_.grep({ / ^ @allowed* $ / }).elems
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (<ad bd aaab baa badab>,     'ab'),  output => 2 },
        %{ input => (<a b c ab ac bc abc>,       'abc'), output => 7 },
        %{ input => (<cc acd b ba bac bad ac d>, 'cad'), output => 4 },
    ];

    for @tests {
        consistent-strings( |.<input> ).&is-deeply: .<output>, .<text>;

    } # end of for @tests
} # end of multi MAIN (:$test!)


