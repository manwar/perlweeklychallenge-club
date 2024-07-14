#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 277 Task 2 Strong Pairs
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to return the count of all strong pairs in the given array.
# A pair of integers x and y is called strong pair if
# it satisfies: 0 < |x - y| < min(x, y).
# Example 1 Input: @ints = (1, 2, 3, 4, 5)
#           Ouput: 4
#   Strong Pairs: (2, 3), (3, 4), (3, 5), (4, 5)
# Example 2 Input: @ints = (5, 7, 1, 7)
#           Ouput: 1
#   Strong Pairs: (5, 7)
#=============================================================================

use v5.40;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say strongPair(@ARGV);

sub strongPair(@ints)
{
    use List::Util qw/min uniqnum/;

    # Remove duplicate values
    @ints = uniqnum sort { $a <=> $b } @ints;

    my $count = 0;
    while ( defined(my $first = shift @ints) )
    {
        for my $second ( @ints )
        {
            $count++ if abs($first - $second) < min($first, $second);
            if ( $Verbose )
            {
                my $abs = abs($first - $second);
                my $min = min($first, $second);
                say "($first,$second): abs=$abs min=$min count=$count";
            }
        }
    }
    return $count;
}

sub runTest
{
    use Test2::V0;

    is( strongPair(1,2,3,4,5), 4, "Example 1");
    is( strongPair(5,7,1,7  ), 1, "Example 2");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
