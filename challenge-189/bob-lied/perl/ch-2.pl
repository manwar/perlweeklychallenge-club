#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 189 Array Degree
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of 2 or more non-negative integers.
# Write a script to find out the smallest slice, i.e. contiguous subarray of
# the original array, having the degree of the given array.
# The degree of an array is the maximum frequency of an element in the array.
#
# Example 1 Input: @array = (1, 3, 3, 2) Output: (3, 3)
#   The degree of the given array is 2.
#   The possible subarrays having the degree 2 are as below:
#   (3, 3)
#   (1, 3, 3)
#   (3, 3, 2)
#   (1, 3, 3, 2)
#   And the smallest of all is (3, 3).
#
# Example 2 Input: @array = (1, 2, 1, 3) Output: (1, 2, 1)
# Example 3 Input: @array = (1, 3, 2, 1, 2) Output: (2, 1, 2)
# Example 4 Input: @array = (1, 1, 2, 3, 2) Output: (1, 1)
# Example 5 Input: @array = (2, 1, 2, 1, 1) Output: (1, 2, 1, 1)
#=============================================================================

use v5.36;

use List::Util qw/min/;
use List::MoreUtils qw/frequency indexes/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub arrayDegree($array)
{
    my %f = frequency($array->@*);
    my $degree = ( sort { $b <=> $a } values %f )[0];

    my $smallest = scalar(@$array);
    my @slice = ( 0, scalar(@$array)-1 );

    # For every possible value that has that degree
    for my $v ( grep { $f{$_} == $degree } keys %f )
    {
        # The slice will have that value as its first and last index,
        # so find every index where that value exists in the array.
        my @idx = List::MoreUtils::indexes { $_ == $v } $array->@*;

        # There must be $degree occurrences of the value, so take that
        # group of indexes at a time
        for ( my $i = 0 ; $i <= (@idx - $degree) ; $i++ )
        {
            my $span = $idx[$i + $degree - 1] - $idx[$i];
            if ( $span < $smallest )
            {
                $smallest = $span;
                @slice = ( $idx[$i], $idx[$i] + $span );
            }
        }
    }
    return [ $array->@[$slice[0] .. $slice[1]] ];
}

sub runTest
{
    use Test2::V0;

    is( arrayDegree( [1,3,3,2]   ), [3,3],     "Example 1");
    is( arrayDegree( [1,2,1,3]   ), [1,2,1],   "Example 2");
    is( arrayDegree( [1,3,2,1,2] ), [2,1,2],   "Example 3");
    is( arrayDegree( [1,1,2,3,2] ), [1,1],     "Example 4");
    is( arrayDegree( [2,1,2,1,1] ), [1,2,1,1], "Example 5");

    done_testing;
}

