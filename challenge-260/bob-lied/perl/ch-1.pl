#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 260 Task 1 Unique Occurrences
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to return 1 if the number of occurrences of each value
# in the given array is unique or 0 otherwise.
# Example 1 Input: @ints = (1,2,2,1,1,3)
#           Output: 1
#   The number 1 occurred 3 times.
#   The number 2 occurred 2 times.
#   The number 3 occurred 1 time.
#   All occurrences are unique, therefore the output is 1.
# Example 2 Input: @ints = (1,2,3)
#           Output: 0
# Example 3 Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
#           Output: 1
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say uniqOcc(@ARGV);

sub uniqOcc(@ints)
{
    use List::MoreUtils qw/frequency all/;

    my %intFrequency = frequency(@ints);
    my %occurFreq = frequency( values %intFrequency );

    return ( all { $_ == 1 } values %occurFreq ) ? 1 : 0;
}

sub runTest
{
    use Test2::V0;

    is( uniqOcc(1,2,2,1,1,3),            1, "Example 1");
    is( uniqOcc(1,2,3)      ,            0, "Example 2");
    is( uniqOcc(-2,0,1,-2,1,1,0,1,-2,9), 1, "Example 3");

    done_testing;
}
