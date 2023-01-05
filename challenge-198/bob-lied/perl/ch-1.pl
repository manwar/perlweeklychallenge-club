#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Perl Weekly Challenge Week 198, Task 1 Max Gap
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of integers, @list.
# Write a script to find the total pairs in the sorted list where 2
# consecutive elements has the max gap. If the list contains less then two
# elements then return 0.
#
# Example 1 Input:  @list = (2,5,8,1) Output: 2
# Since the sorted list (1,2,5,8) has 2 such pairs (2,5) and (5,8)
#
# Example 2 Input: @list = (3) Output: 0
#=============================================================================

use v5.36;

use List::MoreUtils qw/slide after_incl/;
use List::Util qw/max/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub maxGap(@list)
{
    return 0 if @list < 2;
    my @gap = slide { $b - $a } sort { $a <=> $b } @list;
    my @m = after_incl { $_ == $gap[-1] } @gap;
    return scalar(@m);
}

sub maxGap2($list)
{
    my $len = @$list;
    return 0 if $len < 2;

    my @sorted = sort { $a <=> $b } $list->@*;
    my $maxGap = 0;
    my %gapCount;
    for ( my $i = 1 ; $i < $len ; $i++ )
    {
        my $gap = $sorted[$i] - $sorted[$i-1];
        $gapCount{$gap}++;
        $maxGap = $gap if $gap > $maxGap
    }
    return %gapCount{$maxGap};
}

sub runTest
{
    use Test::More;

    is( maxGap( 2,5,8,1  ), 2, "Example 1");
    is( maxGap( 3        ), 0, "Example 2");
    is( maxGap( 4,8,12,16), 3, "Multiples");

    is( maxGap2( [ 2,5,8,1 ]  ), 2, "v2 Example 1");
    is( maxGap2( [ 3       ]  ), 0, "v2 Example 2");
    is( maxGap2( [ 4,8,12,16 ]), 3, "v2 Multiples");

    done_testing;
}

