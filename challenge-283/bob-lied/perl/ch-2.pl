#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 283 Task 2 Digit Count Value
#=============================================================================
# You are given an array of positive integers, @ints.
# Write a script to return true if for every index i in the range
# 0 <= i < size of array, the digit i occurs exactly the $ints[$i]
# times in the given array otherwise return false.
# Example 1 Input: @ints = (1, 2, 1, 0)
#           Output: true
#   $ints[0] = 1, the digit 0 occurs exactly 1 time.
#   $ints[1] = 2, the digit 1 occurs exactly 2 times.
#   $ints[2] = 1, the digit 2 occurs exactly 1 time.
#   $ints[3] = 0, the digit 3 occurs 0 time.
# Example 2 Input: @ints = (0, 3, 0)
#           Output: false
#   $ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
#   $ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
#   $ints[2] = 0, the digit 2 occurs exactly 0 time.
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say digCountVal(@ARGV) ? "true" : "false";

sub digCountVal(@ints)
{
    my @appear = (0) x scalar(@ints);
    $appear[$_]++ for @ints;

    use List::Util qw/all/;
    return all { $appear[$_] == $ints[$_] } 0 .. $#ints;
}

sub runTest
{
    use Test2::V0;

    is( digCountVal(1,2,1,0), true,  "Example 1");
    is( digCountVal(0,3,0  ), false, "Example 1");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
