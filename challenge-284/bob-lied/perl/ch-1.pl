#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 284 Task 1 Lucky Integer
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find the lucky integer if found otherwise return -1.
# If there are more than one then return the largest.
# A lucky integer is an integer that has a frequency in the array equal
# to its value.
# Example 1 Input: @ints = (2, 2, 3, 4)
#           Output: 2
# Example 2 Input: @ints = (1, 2, 2, 3, 3, 3)
#           Output: 3
# Example 3 Input: @ints = (1, 1, 1, 3)
#           Output: -1
#=============================================================================

use v5.40;
use List::Util qw/max/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say lucky(@ARGV);

sub lucky(@ints)
{
    my %freq;
    $freq{$_}++ for @ints;
    max -1, grep { $freq{$_} == $_ } keys %freq;
}

sub runTest
{
    use Test2::V0;

    is( lucky(2, 2, 3, 4      ),  2, "Example 1");
    is( lucky(1, 2, 2, 3, 3, 3),  3, "Example 2");
    is( lucky(1, 1, 1, 3      ), -1, "Example 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
