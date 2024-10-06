#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 289 Task 1 Third Maximum
#=============================================================================
# You are given an array of integers, @ints.
# Write a script to find the third distinct maximum in the given array.
# If third maximum doesn’t exist then return the maximum number.
# Example 1 Input: @ints = (5, 6, 4, 1) Output: 4
# Example 2 Input: @ints = (4, 5) Output: 5
#   In the given array, the third maximum doesn't exist
#   therefore returns the maximum.
# Example 3 Input: @ints =  (1, 2, 2, 3) Output: 1
#=============================================================================

use v5.40;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

say thirdMax(@ARGV);

sub thirdMax(@ints)
{
    if    ( @ints == 0 ) { return undef }
    elsif ( @ints == 1 ) { return $ints[0] }
    elsif ( @ints == 2 ) { return ( $ints[0] > $ints[1] ? $ints[0] : $ints[1] ) }

    my @top3 = (-0xFFFFFFFF) x 4;
    while ( defined (my $n = shift @ints) )
    {
        next if ( $n == $top3[0] || $n == $top3[1] || $n == $top3[2] );
        for my $i ( 2, 1, 0 )
        {
            if ( $n > $top3[$i] )
            {
                $top3[$i+1] = $top3[$i];
                $top3[$i] = $n;
            }
        }
    }
    return $top3[2];
}

sub runTest
{
    use Test2::V0;

    is( thirdMax(5,6,4,1), 4, "Example 1");
    is( thirdMax(4,5    ), 5, "Example 2");
    is( thirdMax(1,2,2,3), 1, "Example 3");

    my @ints = ( 999 );
    push @ints, int(rand(1000)) for 1..197;
    push @ints, 997;
    push @ints, int(rand(1000)) for 1..499;
    push @ints, 998;
    push @ints, int(rand(1000)) for 1..599;
    is( thirdMax(@ints), 997, "Thousand numbers");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
        label => sub { },
    });
}
