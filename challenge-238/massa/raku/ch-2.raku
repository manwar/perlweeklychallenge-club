#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 2: Persistence Sort

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of integers.

Write a script to sort the given array in increasing order with respect to the
count of steps required to obtain a single-digit number by multiplying its
digits recursively for each array element. If any two numbers have the same
count of steps, then print the smaller number first.

=head3 Example 1:

Input: @int = (15, 99, 1, 34)
Output: (1, 15, 34, 99)

15 => 1 x 5 => 5 (1 step)
99 => 9 x 9 => 81 => 8 x 1 => 8 (2 steps)
1  => 0 step
34 => 3 x 4 => 12 => 1 x 2 => 2 (2 steps)

=head3 Example 2:

Input: @int = (50, 25, 33, 22)
Output: (22, 33, 50, 25)

50 => 5 x 0 => 0 (1 step)
25 => 2 x 5 => 10 => 1 x 0 => 0 (2 steps)
33 => 3 x 3 => 9 (1 step)
22 => 2 x 2 => 4 (1 step)

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

my sub persistence($_) {
  .comb.elems > 1 and 1 + persistence([*] .comb)
}

sub persistence-sort(@_) {
  @_.sort.sort: *.&persistence
}

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (15, 99, 1, 34),  output => (1, 15, 34, 99) },
        %{ input => (50, 25, 33, 22), output => (22, 33, 50, 25) },
    ];

    for @tests {
        persistence-sort( .<input> ).&is-deeply: .<output>, .<text>;

    } # end of for @tests
} # end of multi MAIN (:$test!)


