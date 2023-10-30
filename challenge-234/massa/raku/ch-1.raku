#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Common Characters

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of words made up of alphabetic characters only.

Write a script to return all alphabetic characters that show up in all words including duplicates.

=head3 Example 1:

Input: @words = ("java", "javascript", "julia")
Output: ("j", "a")

The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.

=head3 Example 2:

Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

=head3 Example 3:

Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub common-characters(@_) {
  ([∩] @_».comb».Bag).kv.map({ $^a xx $^b }).flat
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => <java javascript julia>, output => <j a> },
        %{ input => <bella label roller>,    output => <e l l> },
        %{ input => <cool lock cook>,        output => <c o> },
    ];

    for @tests {
        common-characters( .<input> ).&is-deeply: .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (Bool :$test!)


