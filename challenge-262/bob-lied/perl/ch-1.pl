#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 262 Task 1 Max Positive Negative
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to return the maximum number of either positive
# or negative integers in the given array.
# Example 1 Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
#           Output: 4
#   Count of positive integers: 4
#   Count of negative integers: 3
#   Maximum of count of positive and negative integers: 4
# Example 2 Input: @ints = (-1, -2, -3, 1)
#           Output: 3
# Example 3 Input: @ints = (1,2)
#           Output: 2
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say maxPosNeg(@ARGV);

sub maxPosNeg(@ints)
{
    my ($pos, $neg) = (0, 0);
    foreach ( @ints )
    {
        if    ( $_ > 0 ) { $pos++ }
        elsif ( $_ < 0 ) { $neg++ }
    }
    return ( $pos > $neg ) ? $pos : $neg;
}

sub runTest
{
    use Test2::V0;

    is( maxPosNeg(-3, 1, 2, -1, 3, -2, 4), 4, "Example 1");
    is( maxPosNeg(-1, -2, -3, 1         ), 3, "Example 2");
    is( maxPosNeg(1, 2                  ), 2, "Example 3");
    is( maxPosNeg(), 0, "Empty list");

    done_testing;
}
