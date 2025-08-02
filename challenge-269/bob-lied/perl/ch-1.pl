#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 269 Task 1 Bitwise OR
#=============================================================================
# You are given an array of positive integers, @ints.
# Write a script to find out if it is possible to select two or more
# elements of the given array such that the bitwise OR of the selected
# elements has atlest one trailing zero in its binary representation.
# Example 1 Input: @ints = (1, 2, 3, 4, 5)
#           Output: true
#   We pick 2 and 4; 2|4 = 6; has a trailing zero --> true.
# Example 2 Input: @ints = (2, 3, 8, 16)
#           Output: true
# Example 3 Input: @ints = (1, 2, 5, 7, 9)
#           Output: false
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub task1(@ints)
{
    return false unless @ints;
    return !($ints[0] & 1) if scalar(@ints) == 1;

    my $evenCount = 0;
    while ( defined(my $n = shift @ints) )
    {
        return true if (($n & 1) == 0) && ++$evenCount > 1;
    }
    return false;
}

sub runTest
{
    use Test2::V0;
use builtin qw/true false/; no warnings "experimental::builtin";

    is( task1(1,2,3,4,5),  true, "Example 1");
    is( task1(2,3,8,16),   true, "Example 2");
    is( task1(1,2,5,7,9), false, "Example 3");
    is( task1(4),          true, "One even number");
    is( task1(5),         false, "One odd number");
    is( task1(),          false, "Empty list");

    done_testing;
}
