#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 290 Task 1 Double Exist
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find if there exist two indices $i and $j such that:
#   1) $i != $j
#   2) 0 <= ($i, $j) < scalar @ints
#   3) $ints[$i] == 2 * $ints[$j]
# Example 1 Input: @ints = (6, 2, 3, 3)
#           Output: true
#   For $i = 0, $j = 2: $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]
# Example 2 Input: @ints = (3, 1, 4, 13)
#           Output: false
# Example 3 Input: @ints = (2, 1, 4, 2)
#           Output: true
#   For $i = 2, $j = 3: $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say dblExist(@ARGV);

sub dblExist(@ints)
{
    while ( defined(my $i = shift(@ints)) )
    {
        for my $j ( @ints )
        {
            return true if $i == 2 * $j;
        }
    }
    return false;
}

sub runTest
{
    use Test2::V0;

    is( dblExist(6, 2, 3,  3),  true, "Example 1");
    is( dblExist(3, 1, 4, 13), false, "Example 2");
    is( dblExist(2, 1, 4,  2),  true, "Example 3");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
