#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 250 Task 1 Smallest Index
#=============================================================================
# You are given an array of integers, @ints.  Write a script to find the
# smallest index i such that i mod 10 == $ints[i] otherwise return -1.
# Example 1 Input: @ints = (0, 1, 2)
#           Output: 0
# Example 2 Input: @ints = (4, 3, 2, 1)
#           Output: 2
# Example 3 Input: @ints = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
#           Output: -1
#=============================================================================

use v5.38;

use List::Util qw/first/;

use Getopt::Long;
my $DoTest  = 0;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

say smallestIndex(@ARGV);

sub smallestIndex(@ints)
{
    return (first { ($_ % 10) == $ints[$_] } 0 .. $#ints) // -1;
}

sub runTest
{
    use Test2::V0;

    is( smallestIndex(0,1,2  ),  0, "Example 1");
    is( smallestIndex(4,3,2,1),  2, "Example 2");
    is( smallestIndex(1..9,0 ), -1, "Example 3");

    done_testing;
}
