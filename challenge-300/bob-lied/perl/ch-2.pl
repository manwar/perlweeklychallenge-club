#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 300 Task 2 Nested Array
#=============================================================================
# You are given an array of integers, @ints of length n containing
# permutation of the numbers in the range [0, n - 1].
# Write a script to build a set, set[i] = ints[i], ints[ints[i]],
# ints[ints[ints[i]]], ..., subjected to the following rules:
# 1. The first element in set[i] starts with the selection of elements ints[i].
# 2. The next element in set[i] should be ints[ints[i]], and then
#    ints[ints[ints[i]]], and so on.
# 3. We stop adding right before a duplicate element occurs in set[i].
# Return the longest length of a set set[i].
#                          [0][1][2][3][4][5][6]
# Example 1 Input: @ints = (5, 4, 0, 3, 1, 6, 2)
#           Output: 4
#   set[0] = { int[0], int[int[0]], int[int[int[0]]] int[int[int[int[0]]]] }
#          = { 5,      int[5],      int[int[5]]      int[int[int[5]]]      }
#          = { 5,      6            int[6]           int[int[6]]           }
#          = { 5,      6,           2                int[2]                }
#          = { 5,      6,           2                0                     }
#          The next term would be int[0], which repeats 5.
#
# Example 2 Input: @ints = (0, 1, 2) Output: 1
#=============================================================================

use v5.40;
use List::Util qw/max/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say $_ for @ARGV;   # TODO command line processing here

sub nest(@ints)
{
    my @set;
    for ( 0 .. $#ints )
    {
        $set[$_] = make($_, @ints);
    }
    return max map { scalar(@$_) } @set;
}

sub make($i, @ints)
{
    my @set = ( $ints[$i] );
    my %seen = ( $ints[$i] => true );
    for ( 1 .. scalar @ints )
    {
        my $next = $ints[$set[-1]];
        last if exists $seen{$next};

        push @set, $ints[$set[-1]];
        $seen{$next} = true;
    }

    if($Verbose){say "set[$i]={@set}"}
    return [ @set ];
}

sub runTest
{
    use Test2::V0;

    is( nest(5,4,0,3,1,6,2), 4, "Example 1");
    is( nest(0,1,2        ), 1, "Example 2");

    done_testing;
}
