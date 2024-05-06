#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#
# ch-2.pl Perl Weekly Challenge 268 Task 2 Number Game
#=============================================================================
# You are given an array of integers, @ints, with even number of elements.
# Write a script to create a new array made up of elements of the given
# array. Pick the two smallest integers and add it to new array in decreasing
# order i.e. high to low. Keep doing until the given array is empty.
# Example 1 Input: @ints = (2, 5, 3, 4)
#           Output: (3, 2, 5, 4)
#   Round 1: we picked (2, 3) and push it to the new array (3, 2)
#   Round 2: we picked the remaining (4, 5) and push it to the new array (5, 4)
# Example 2 Input: @ints = (9, 4, 1, 3, 6, 4, 6, 1)
#           Output: (1, 1, 4, 3, 6, 4, 9, 6)
# Example 3 Input: @ints = (1, 2, 2, 3)
#           Output: (2, 1, 3, 2)
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub game(@ints)
{
    return [ (sort { $a <=> $b } @ints)[ map { 2*$_+1, 2*$_ } 0 .. $#ints/2 ] ];
}

sub runTest
{
    use Test2::V0;

    is( game(2,5,3,4),         [3,2,5,4], "Example 1");
    is( game(9,4,1,3,6,4,6,1), [1,1,4,3,6,4,9,6], "Example 2");
    is( game(1,2,2,3),         [2,1,3,2], "Example 3");

    done_testing;
}
