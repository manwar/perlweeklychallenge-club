#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Running Sum

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers.

Write a script to return the running sum of the given array. The running sum
can be calculated as sum[i] = num[0] + num[1] + …. + num[i].

=head3 Example 1:

Input: @int = (1, 2, 3, 4, 5)
Output: (1, 3, 6, 10, 15)

=head3 Example 2:

Input: @int = (1, 1, 1, 1, 1)
Output: (1, 2, 3, 4, 5)

=head3 Example 3:

Input: @int = (0, -1, 1, 2)
Output: (0, -1, 0, 2)

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub runinng-sum(@_) {
  [\+] @_
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (1, 2, 3, 4, 5), output => (1, 3, 6, 10, 15) },
        %{ input => (1, 1, 1, 1, 1), output => (1, 2, 3, 4, 5) },
        %{ input => (0, -1, 1, 2),   output => (0, -1, 0, 2) },
    ];

    for @tests {
        runinng-sum( .<input> ).&is-deeply: .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (Bool :$test!)


