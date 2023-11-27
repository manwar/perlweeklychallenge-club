#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 172 Task 2 Five-number Summary 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to compute the five-number summary of the given set
# The five-number summary is a set of descriptive statistics that provides
# information about a dataset. It consists of the five most important
# sample percentiles:
#   the sample minimum (smallest observation)
#   the lower quartile or first quartile
#   the median (the middle value)
#   the upper quartile or third quartile
#   the sample maximum (largest observation)
# Example 1: Input: @int = (0, 0, 1, 2, 63, 61, 27, 13)
#           Output: 0.00    0.75    7.50   20.88   35.50   63.00
#=============================================================================

use v5.38;
use builtin qw/floor ceil/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

show(fiveSummary(@ARGV));

sub show($five)
{
    if ( $Verbose )
    {
        printf "     minimum: %12.3f\n", $five->[0];
        printf "1st quartile: %12.3f\n", $five->[1];
        printf "      median: %12.3f\n", $five->[2];
        printf "3nd quartile: %12.3f\n", $five->[3];
        printf "     maximum: %12.3f\n", $five->[4];
    }
    else
    {
        say "(", join(", ", $five->@*), ")";
    }
}

sub median($ref)
{
    my $len = scalar( @$ref );
    if ( $len % 2 )
    {
        # Odd length, take middle element
        return $ref->[ int($len/2) ];
    }
    else
    {
        # Even length, take average of middle 2
        my $mid = $len / 2;
        return ( $ref->[$mid] + $ref->[$mid-1] ) / 2;
    }
}

sub fiveSummary(@list)
{
    my @sorted = sort { $a <=> $b } @list;
    my $len = scalar( @list );
    my $mid = $len / 2;
    my ($lowtop, $hibottom);
    if ( $len % 2 )
    {
        # Odd
        $lowtop = $hibottom = floor($mid);
    }
    else
    {
        # Even
        $lowtop = ($hibottom = $mid) - 1;
    }

    my @summary = (
        $sorted[0],
        median( [ @sorted[0 .. $lowtop ] ]),
        median( \@sorted ),
        median( [ @sorted[ $hibottom .. $#list] ]),
        $sorted[-1]
        );
    return \@summary;
}

sub runTest
{
    use Test2::V0;

    is( median([3,5,7]), 5, "Median odd length");
    is( median([3,5,7,9]), 6, "Median even length");

    is( fiveSummary(0, 0, 1, 2, 63, 61, 27, 13),
                    [0.0, 0.5, 7.5, 44.0, 63.0 ], "Example 1");

    done_testing;
}
