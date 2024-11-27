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

use List::MoreUtils qw/last_index/;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say "(", join(", ", nextPerm(@ARGV)->@*), ")";

sub nextPerm(@ints)
{
    my $pivot = -1;
    for my $p ( reverse 0 .. ($#ints-1) )
    {
        if ( $ints[$p] lt $ints[$p+1] )
        {
            $pivot = $p;
            last;
        }
    }
    if ( $pivot < 0 )
    {
        return [ sort @ints ];
    }
    my $successor = last_index { $_ gt $ints[$pivot] } @ints;

    ($ints[$pivot], $ints[$successor]) = ($ints[$successor], $ints[$pivot]);

    @ints[$pivot+1 .. $#ints] = reverse @ints[$pivot+1 .. $#ints];

    return \@ints;
}

sub runTest
{
    use Test2::V0;

    is( nextPerm(1,2,3), [1,3,2], "Example 1");
    is( nextPerm(2,1,3), [2,3,1], "Example 2");
    is( nextPerm(3,1,2), [3,2,1], "Example 3");

    is( nextPerm(3,2,1), [1,2,3], "Roll over");

    is( nextPerm(1,3,5,4,2), [1,4,2,3,5], "1 3 5 4 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
