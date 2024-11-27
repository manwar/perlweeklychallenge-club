#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 293 Task 2 Boomerang
#=============================================================================
# You are given an array of points, (x, y).
# Write a script to find out if the given points are a boomerang.  A boomerang
# is a set of three points that are all distinct and not in a straight line.
# Example 1 Input: @points = ( [1, 1], [2, 3], [3, 2] ) Output: true
# Example 2 Input: @points = ( [1, 1], [2, 2], [3, 3] ) Output: false
# Example 3 Input: @points = ( [1, 1], [1, 2], [2, 3] ) Output: true
# Example 4 Input: @points = ( [1, 1], [1, 2], [1, 3] ) Output: false
# Example 5 Input: @points = ( [1, 1], [2, 1], [3, 1] ) Output: false
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

# Usage: $0  1,3  3,1  2,4
say boomerang( map { [ split(/,/, $_) ] } @ARGV );

sub boomerang(@points)
{
    # Points are collinear if slope from 1 to 2 is same as slope from 2 to 3
    my ($x1, $y1) = $points[0]->@*;
    my ($x2, $y2) = $points[1]->@*;
    my ($x3, $y3) = $points[2]->@*;
    return ($y3 - $y2)*($x2 - $x1) != ($y2 - $y1)*($x3 - $x2) ;
}

sub runTest
{
    use Test2::V0;

    is( boomerang( [1, 1], [2, 3], [3, 2] ),  true, "Example 1");
    is( boomerang( [1, 1], [2, 2], [3, 3] ), false, "Example 2");
    is( boomerang( [1, 1], [1, 2], [2, 3] ),  true, "Example 3");
    is( boomerang( [1, 1], [1, 2], [1, 3] ), false, "Example 4");
    is( boomerang( [1, 1], [2, 1], [3, 1] ), false, "Example 5");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
