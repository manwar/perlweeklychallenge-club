#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 276 Task 1 Complete Day
#=============================================================================
# You are given an array of integers, @hours.
# Write a script to return the number of pairs that forms a complete day.
# A complete day is defined as a time duration that is an exact multiple
# of 24 hours.
# Example 1 Input: @hours = (12, 12, 30, 24, 24)
#           Output: 2       Pair 1: (12, 12) Pair 2: (24, 24)
# Example 2 Input: @hours = (72, 48, 24, 5)
#           Output: 3       Pairs: (72, 48) (72, 24) (48, 24)
# Example 3 Input: @hours = (12, 18, 24)
#           Output: 0
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say completeDay(@ARGV);

sub completeDay(@hours)
{
    my $complete = 0;
    while ( defined(my $first = shift @hours) )
    {
        for my $second (@hours )
        {
            $complete++ if ($first+$second)%24 == 0;
        }
    }
    return $complete;
}

sub runTest
{
    use Test2::V0;

    is( completeDay(12,12,30,24,24), 2, "Exsmple 1");
    is( completeDay(72,48,24, 5   ), 3, "Exsmple 2");
    is( completeDay(12,18,24      ), 0, "Exsmple 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
