#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 268 Task 1 Magic Number
#=============================================================================
# You are given two arrays of integers of same size, @x and @y.
# Write a script to find the magic number that when added to each elements
# of one of the array gives the second array. Elements order is not important.
# Example 1 Input: @x = (3, 7, 5) @y = (9, 5, 7)
#           Output: 2
#   The magic number is 2.
#   @x = (3, 7, 5)
#      +  2  2  2
#   @y = (5, 9, 7)
# Example 2 Input: @x = (1, 2, 1) @y = (5, 4, 4)
#           Output: 3
# Example 3 Input: @x = (2) @y = (5)
#           Output: 3
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub magicNumber($x, $y)
{
    use List::Util qw/min/;
    return min($y->@*) - min($x->@*);
}

sub runTest
{
    use Test2::V0;

    is( magicNumber([3,7,5], [9,5,7]), 2, "Example 1");
    is( magicNumber([1,2,1], [5,4,4]), 3, "Example 2");
    is( magicNumber([2    ], [5    ]), 3, "Example 3");

    done_testing;
}
