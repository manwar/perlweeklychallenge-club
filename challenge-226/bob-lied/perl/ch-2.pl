#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Zero Array 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of non-negative integers, @ints.
# Write a script to return the minimum number of operations to make every
# element equal zero.
# In each operation, you are required to pick a positive number less than or
# equal to the smallest element in the array, then subtract that from each
# positive element in the array.
# Example 1: Input: @ints = (1, 5, 0, 3, 5)
#           Output: 3
#   operation 1: pick 1 => (0, 4, 0, 2, 4)
#   operation 2: pick 2 => (0, 2, 0, 0, 2)
#   operation 3: pick 2 => (0, 0, 0, 0, 0)
# Example 2: Input: @ints = (0)
#           Output: 0
# Example 3: Input: @ints = (2, 1, 4, 0, 3)
#           Output: 4
#   operation 1: pick 1 => (1, 0, 3, 0, 2)
#   operation 2: pick 1 => (0, 0, 2, 0, 1)
#   operation 3: pick 1 => (0, 0, 1, 0, 0)
#   operation 4: pick 1 => (0, 0, 0, 0, 0)
##########
# The best move at each turn will be to remove (all copies of) the minimum,
# so the answer will be the number of unique non-zero elements.
#=============================================================================

use v5.36;

use List::Util qw/uniq/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say zeroArray(@ARGV);

sub zeroArray(@ints)
{
    return scalar(grep { $_ != 0 } uniq @ints);
}

sub runTest
{
    use Test2::V0;

    is( zeroArray(1,5,0,3,5), 3, "Example 1");
    is( zeroArray(0),         0, "Example 2");
    is( zeroArray(2,1,4,0,3), 4, "Example 3");

    done_testing;
}
