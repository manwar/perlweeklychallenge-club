#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 261 Task 2 Multiply By Two
#=============================================================================
# You are given an array of integers, @ints and an integer $start.
# Write a script to do the followings:
# a) Look for $start in the array @ints, if found multiply the number by 2
# b) If not found stop the process otherwise repeat
# In the end return the final value.
# Example 1 Input: @ints = (5,3,6,1,12) and $start = 3
#           Output: 24
#   Step 1: 3 is in the array so 3 x 2 = 6
#   Step 2: 6 is in the array so 6 x 2 = 12
#   Step 3: 12 is in the array so 12 x 2 = 24
#   24 is not found in the array so return 24.
# Example 2 Input: @ints = (1,2,4,3) and $start = 1
#           Output: 8
#   Step 1: 1 is in the array so 1 x 2 = 2
#   Step 2: 2 is in the array so 2 x 2 = 4
#   Step 3: 4 is in the array so 4 x 2 = 8
#   8 is not found in the array so return 8.
# Example 3 Input: @ints = (5,6,7) and $start = 2
#   Output: 2
#   2 is not found in the array so return 2.
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Start = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "start" => \$Start);
exit(!runTest()) if $DoTest;

say multiplyByTwo($Start, @ARGV);

sub multiplyByTwo($start, @ints)
{
    my %present = map { $_ => true } @ints;
    $start *= 2 while ( exists $present{$start} );
    return $start;
}

sub runTest
{
    use Test2::V0;

    is( multiplyByTwo(3, (5,3,6,1,12) ), 24, "Example 1");
    is( multiplyByTwo(1, (1,2,4,3)    ),  8, "Example 2");
    is( multiplyByTwo(2, (5,6,7)      ),  2, "Example 3");

    done_testing;
}
