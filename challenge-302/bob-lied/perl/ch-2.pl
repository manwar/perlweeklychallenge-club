#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 302 Task 2 Step by Step
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find the minimum positive start value such that
# the step by step sum is never less than one.
# Example 1 Input: @ints = (-3, 2, -3, 4, 2)
#           Output: 5
#   For start value 5: (5)  -3   2  -3   4   2
#                         +\/  +\/ +\/ +\/ +\
#                           2    4   1   5   7
# Example 2 Input: @ints = (1, 2)
#           Output: 1
# Example 3 Input: @ints = (1, -2, -3)
#           Output: 5
#=============================================================================

use v5.40;

use Getopt::Long;
my $DoTest  = false;
GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

say stepByStep(@ARGV);

sub stepByStep(@ints)
{
    use List::Util qw/reductions min/;

    return 1 - min reductions { $a + $b } 0, @ints;
}

sub runTest
{
    use Test2::V0;

    is( stepByStep(-3,  2, -3, 4, 2), 5, "Example 1");
    is( stepByStep( 1,  2          ), 1, "Example 2");
    is( stepByStep( 1, -2, -3      ), 5, "Example 3");

    done_testing;
}
