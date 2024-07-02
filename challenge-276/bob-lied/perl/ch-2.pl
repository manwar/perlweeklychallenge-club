#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 276 Task 2 Maximum Frequency
#=============================================================================
# You are given an array of positive integers, @ints.
# Write a script to return the total number of elements in the given
# array which have the highest frequency.
# Example 1 Input: @ints = (1, 2, 2, 4, 1, 5)
#           Ouput: 4
#   The maximum frequency is 2.
#   The elements 1 and 2 have the maximum frequency.
# Example 2 Input: @ints = (1, 2, 3, 4, 5)
#           Ouput: 5
#   The maximum frequency is 1.
#   The elements 1, 2, 3, 4 and 5 has the maximum frequency.
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say maxFreq(@ARGV);

sub maxFreq(@ints)
{
    use List::MoreUtils qw/frequency/;
    use List::Util qw/max sum/;

    my %freq = frequency @ints;
    my $max = max values %freq;

    return sum grep { $_ == $max } values %freq;
}

sub runTest
{
    use Test2::V0;

    is( maxFreq(1,2,2,4,1,5), 4, "Example 1");
    is( maxFreq(1,2,3,4,5  ), 5, "Example 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}

