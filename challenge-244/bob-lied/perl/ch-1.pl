#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 244 Task 1 Count Smaller
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to calculate the number of integers smaller than
# the integer at each index.
# Example 1 Input: @int = (8, 1, 2, 2, 3)
#           Output: (4, 0, 1, 1, 3)
#   For index = 0, count of elements less 8 is 4.
#   For index = 1, count of elements less 1 is 0.
#   For index = 2, count of elements less 2 is 1.
#   For index = 3, count of elements less 2 is 1.
#   For index = 4, count of elements less 3 is 3.
# Example 2 Input: @int = (6, 5, 4, 8)
#           Output: (2, 1, 0, 3)
# Example 3 Input: @int = (2, 2, 2)
#           Output: (0, 0, 0)
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;
my $DoBenchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$DoBenchmark);
exit( !runTest() ) if $DoTest;
exit( runBenchmark($DoBenchmark) ) if $DoBenchmark;

say "(", join(",", countSmaller_C(\@ARGV)->@*), ")";

sub countSmaller_A($nums)
{
    my @sorted = sort { $a <=> $b } $nums->@*;
    my @smaller = ();
    for my $i ( $nums->@* )
    {
        my $count = 0;
        for my $j ( @sorted )
        {
            last if $j >= $i;
            $count++
        }
        push @smaller, $count;
    }
    return \@smaller;
}

sub countSmaller_B($nums)
{
    use List::Util qw/sum0/;
    my %freq;
    $freq{$_}++ for $nums->@*;

    return [ map { my $i = $_; sum0 @freq{ grep { $_ < $i } keys %freq } } $nums->@* ];
}

sub countSmaller_C($nums)
{
    my @sorted = sort { $a <=> $b } $nums->@*;

    my %smaller;
    my $lessCount = 0;
    while ( defined(my $i = shift @sorted) )
    {
        if ( ! exists $smaller{$i} )
        {
            $smaller{$i} = $lessCount;
        }
        $lessCount++
    }

    return [ @smaller{$nums->@*} ];
}

sub runTest
{
    use Test2::V0;

    is( countSmaller_A([8,1,2,2,3]), [4,0,1,1,3], "A Example 1");
    is( countSmaller_A([6,5,4,8  ]), [2,1,0,3  ], "A Example 2");
    is( countSmaller_A([2,2,2    ]), [0,0,0    ], "A Example 3");

    is( countSmaller_B([8,1,2,2,3]), [4,0,1,1,3], "B Example 1");
    is( countSmaller_B([6,5,4,8  ]), [2,1,0,3  ], "B Example 2");
    is( countSmaller_B([2,2,2    ]), [0,0,0    ], "B Example 3");

    is( countSmaller_C([8,1,2,2,3]), [4,0,1,1,3], "C Example 1");
    is( countSmaller_C([6,5,4,8  ]), [2,1,0,3  ], "C Example 2");
    is( countSmaller_C([2,2,2    ]), [0,0,0    ], "C Example 3");
    is( countSmaller_C([0,1,2,3,4]), [0,1,2,3,4], "C Example x");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;
    my @data = map { int(rand(100)) } 1..100;

    cmpthese($repeat, {
        "simple   " => sub { countSmaller_A(\@data) },
        "frequency" => sub { countSmaller_B(\@data) },
        "one pass " => sub { countSmaller_C(\@data) },
    });
}
