#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 261 Task 1 Element Digit Sum
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to evaluate the absolute difference between element
# and digit sum of the given array.
# Example 1 Input: @ints = (1,2,3,45) Output: 36
#   Element Sum: 1 + 2 + 3 + 45 = 51
#   Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
#   Absolute Difference: | 51 - 15 | = 36
# Example 2 Input: @ints = (1,12,3) Output: 9
#   Element Sum: 1 + 12 + 3 = 16
#   Digit Sum: 1 + 1 + 2 + 3 = 7
#   Absolute Difference: | 16 - 7 | = 9
# Example 3 Input: @ints = (1,2,3,4) Output: 0
#   Element Sum: 1 + 2 + 3 + 4 = 10
#   Digit Sum: 1 + 2 + 3 + 4 = 10
#   Absolute Difference: | 10 - 10 | = 0
# Example 4 Input: @ints = (236, 416, 336, 350) Output: 1296
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say elementDigitSum(@ARGV);

sub elementDigitSum(@ints)
{
    use List::Util qw/sum0/;
    local $" = '';  # No space when interpolating array into string
    return abs(sum0(@ints) - sum0( split('', "@ints")));
}

sub runTest
{
    use Test2::V0;

    is( elementDigitSum(1,2,3,45       ),   36, "Example 1");
    is( elementDigitSum(1,12,3         ),    9, "Example 2");
    is( elementDigitSum(1,2,3,4        ),    0, "Example 3");
    is( elementDigitSum(236,416,336,350), 1296, "Example 4");
    is( elementDigitSum(               ),    0, "Empty list");

    done_testing;
}
