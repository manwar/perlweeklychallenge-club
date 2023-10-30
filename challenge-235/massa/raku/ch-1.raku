#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Remove One

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers.

Write a script to find out if removing ONLY one integer makes it strictly increasing order.

=head3 Example 1:

Input: @ints = (0, 2, 9, 4, 6)
Output: true

Removing ONLY 9 in the given array makes it strictly increasing order.

=head3 Example 2:

Input: @ints = (5, 1, 3, 2)
Output: false

=head3 Example 3:

Input: @ints = (2, 2, 3)
Output: true

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub remove-one(@_) {
  (^+@_).map({[<] @_[|(^$_), |($_+1 ..^ +@_)]}).any.so
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (0, 2, 9, 4, 6), output => True },
        %{ input => (5, 1, 3, 2),    output => False },
        %{ input => (2, 2, 3),       output => True },
    ];

    for @tests {
        remove-one( .<input> ).&is-deeply: .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (Bool :$test!)


