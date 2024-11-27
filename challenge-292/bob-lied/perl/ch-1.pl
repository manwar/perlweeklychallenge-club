#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 292 Task 1 Twice Largest
#=============================================================================
# You are given an array of integers, @ints, where the largest integer
# is unique.  Write a script to find whether the largest element in the
# array is at least twice as big as every element in the given array.
# If it is return the index of the largest element or return -1 otherwise.
# Example 1 Input: @ints = (2, 4, 1, 0)
#           Output: 1
#   The largest integer is 4. For every other elements in the given array
#   is at least twice as big. The index value of 4 is 1.
# Example 2 Input: @ints = (1, 2, 3, 4)
#           Output: -1
#   The largest integer is 4. 4 is less than twice the value of 3, so we
#   return -1.
#=============================================================================

use v5.40;
use List::Util qw/all/;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say twiceLargest(@ARGV);

sub twiceLargest(@ints)
{
    return -1 unless @ints;
    my ($place, $largest) = (0, $ints[0]);
    for my ($i, $val) (indexed @ints)
    {
        ($place, $largest) = ($i, $val) if ( $val > $largest );
    }
    delete $ints[$place];
    return ( all { $_*2 <= $largest } @ints) ? $place : -1;
}

sub runTest
{
    use Test2::V0;

    is( twiceLargest(2,4,1,0),  1, "Example 1");
    is( twiceLargest(1,2,3,4), -1, "Example 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

