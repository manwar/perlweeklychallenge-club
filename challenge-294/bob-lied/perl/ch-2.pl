#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 294 Task 2 Next Permutation
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find out the next permutation of the given array.
# The next permutation of an array of integers is the next lexicographically
# greater permutation of its integer.
# Example 1 Input: @ints = (1, 2, 3)
#           Output: (1, 3, 2)
#   Permutations of (1, 2, 3) arranged lexicographically:
#   (1, 2, 3) (1, 3, 2) (2, 1, 3) (2, 3, 1) (3, 1, 2) (3, 2, 1)
# 
# Example 2 Input: @ints = (2, 1, 3)
#           Output: (2, 3, 1)
# Example 3 Input: @ints = (3, 1, 2)
# Output: (3, 2, 1)
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say nextPerm(@ARGV);

sub nextPerm(@ints)
{
}

sub runTest
{
    use Test2::V0;

    is( task(), 1, "FAIL");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
