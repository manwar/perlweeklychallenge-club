#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 298 Task 2 Right Interval
#=============================================================================
# You are given an array of @intervals, where $intervals[i] = [starti, endi]
# and each starti is unique.
# The right interval for an interval i is an interval j such that
# startj >= endi and startj is minimized. Please note that i may equal j.
# 
# Write a script to return an array of right interval indices for each
# interval i. If no right interval exists for interval i, then put -1 at index i.
# Example 1 Input: @intervals = ([3,4], [2,3], [1,2])
#           Output: (-1, 0, 1)
#   There is no right interval for [3,4].
#   The right interval for [2,3] is [3,4] since start0 = 3 is the smallest
#   start that is >= end1 = 3.
#   The right interval for [1,2] is [2,3] since start1 = 2 is the smallest
#   start that is >= end2 = 2.
#
# Example 2 Input: @intervals = ([1,4], [2,3], [3,4])
#           Output: (-1, 2, -1)
#   There is no right interval for [1,4] and [3,4].
#   The right interval for [2,3] is [3,4] since start2 = 3 is the smallest
#   start that is >= end1 = 3.
#
# Example 3 Input: @intervals = ([1,2])
#           Output: (-1)
#   There is only one interval in the collection, so it outputs -1.
#
# Example 4 Input: @intervals = ([1,4], [2, 2], [3, 4])
#           Output: (-1, 1, -1)
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say $_ for @ARGV;   # TODO command line processing here

sub rightIntvl(@intervals)
{
    my @byStart = sort { $a->[0] <=> $b->[0] } @intervals;
    my @answer;
    for my $end ( map { $_->[1] } @intervals)
    {
        my @cand = grep { $intervals[$_][0] >= $end } 0 .. $#intervals;
        if ( ! @cand )
        {
            push @answer, -1;
            next;
        }

        my $closest = shift @cand;
        my $diff = $intervals[$closest][0] - $end;
        while ( defined(my $next = shift @cand) )
        {
            if ( $intervals[$next][0] - $end < $diff )
            {
                $closest = $next;
                $diff = $intervals[$next][0];
            }
        }
        push @answer, $closest;
    }
    return \@answer;
}

sub runTest
{
    use Test2::V0;

    is( rightIntvl( [3,4], [2,3], [1,2] ), [-1,0, 1], "Example 1");
    is( rightIntvl( [1,4], [2,3], [3,4] ), [-1,2,-1], "Example 2");
    is( rightIntvl( [1,2]               ), [-1     ], "Example 3");
    is( rightIntvl( [1,4], [2,2], [3,4] ), [-1,1,-1], "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
