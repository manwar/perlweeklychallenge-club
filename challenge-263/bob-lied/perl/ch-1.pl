#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 263 Task 1 Target Index
#=============================================================================
# You are given an array of integers, @ints and a target element $k.
# Write a script to return the list of indices in the sorted array where
# the element is same as the given target element.
# Example 1 Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
#           Output: (1, 2)
#   Sorted array: (1, 2, 2, 3, 4, 5)
#   Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2
# Example 2 Input: @ints = (1, 2, 4, 3, 5), $k = 6
#           Output: ()
#   No element in the given array matching the given target.
# Example 3 Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
#           Output: (4)
#   Sorted array: (1, 2, 2, 3, 4, 5)
#   Target index: (4) as $ints[4] = 4
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Target = 0;
my $DoTest  = 0;

GetOptions("dotest" => \$DoTest, "Target:i" => \$Target);
exit(!runTest()) if $DoTest;

say "(", join(",", targetIndex($Target, @ARGV)->@*), ")";

sub targetIndex($k, @ints)
{
    my ($below, $same) = (0, 0);
    foreach ( @ints )
    {
        if    ( $_ < $k )  { $below++ }
        elsif ( $_ == $k ) { $same++ }
    }
    return [] if $same == 0;

    return [ $below .. ($same + $below - 1) ];
}

sub runTest
{
    use Test2::V0;

    is( targetIndex(2, (1, 5, 3, 2, 4, 2) ), [1, 2], "Example 1");
    is( targetIndex(6, (1, 2, 4, 3, 5   ) ), [    ], "Example 2");
    is( targetIndex(4, (5, 3, 2, 4, 2, 1) ), [  4 ], "Example 3");

    done_testing;
}
