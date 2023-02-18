#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 204 Task 1 Monotonic Array
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to find out if the given array is Monotonic.
# Print 1 if it is otherwise 0.
# An array is Monotonic if it is either monotone increasing or decreasing.
# Monotone increasing: for i <= j , nums[i] <= nums[j]
# Monotone decreasing: for i <= j , nums[i] >= nums[j]
# Example 1 Input: @nums = (1,2,2,3) Output: 1
# Example 2 Input: @nums (1,3,2) Output: 0
# Example 3 Input: @nums = (6,5,5,4) Output: 1
#=============================================================================

use v5.36;

use List::Util qw/all/;
use List::MoreUtils qw/slide/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub isMonotonic($array)
{
    # Any list of two or less is trivially monotonic.
    # No specification for an empty array.  Let's say it is monotonic.
    return 1 if (not defined $array) || $#{$array} < 2;

    # Apply the comparison operator to consecutive elements of array.
    # Result is a list where each element is -1, 0, or 1
    my @compare = slide { $a <=> $b } $array->@*;
    my $isMono = ( all { $_ <= 0 } @compare ) || ( all { $_ >= 0 } @compare );
    return $isMono ? 1 : 0;
}

sub runTest
{
    use Test2::V0;

    is( isMonotonic([         ]), 1, "Empty");
    is( isMonotonic([ 7       ]), 1, "One element");
    is( isMonotonic([ 7,8     ]), 1, "Two elements ascending");
    is( isMonotonic([ 8,2     ]), 1, "Two elements descending");
    is( isMonotonic([3,3,3,3  ]), 1, "Flat");
    is( isMonotonic([3,4,5,3,2]), 0, "Peak");
    is( isMonotonic([5,4,3,4,5]), 0, "Valley");
    is( isMonotonic([5,6,5,4,5]), 0, "Square wave");
    is( isMonotonic([5,5,6,4,5]), 0, "Sawtooth");
    is( isMonotonic([1,2,2,3  ]), 1, "Example 1");
    is( isMonotonic([1,3,2    ]), 0, "Example 1");
    is( isMonotonic([6,5,5,4  ]), 1, "Example 1");

    done_testing;
}

