#! /usr/bin/env raku

# Perl Weekly Challenge 
# © 2023 Shimon Bollinger. All rights reserved.
# Last modified: Mon 15 May 2023 09:17:32 PM EDT
# Version 0.0.1

=begin pod
=TITLE
=head2 Task 1: Min Max

=SUBTITLE
=head2 Submitted by massa

=CHALLENGE
=head2

You are given an array of distinct integers.

Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.

=head3 Example 1:

Input: @ints = (3, 2, 1, 4)
Output: (3, 2)

The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.

=head3 Example 2:

Input: @ints = (3, 1)
Output: -1

=head3 Example 3:

Input: @ints = (2, 1, 3)
Output: (2)

The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.

=SOLUTION

=end pod

# always use the latest version of Raku
use v6.*;

sub without-min-and-max(@_) {
  @_.grep: * ∉ @_.minmax.bounds or -1
} # end of sub my-sub ()

multi MAIN (Bool :$test!) {
    use Test;

    my @tests = [
        %{ input => (3, 2, 1, 4), output => (3, 2), text => 'The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max' },
        %{ input => (3, 1), output => -1, text => 'There are only the min and the max in the array' },
        %{ input => (2, 1, 4), output => (2, ), text => 'The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max' },
    ];

    for @tests {
        is-deeply without-min-and-max( .<input> ), .<output>, .<text>;
    } # end of for @tests
} # end of multi MAIN (Bool :$test!)


