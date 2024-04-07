#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 263 Task 2 Merge Items
#=============================================================================
# You are given two 2-D array of positive integers, $items1 and $items2
# where element is pair of (item_id, item_quantity).
# Write a script to return the merged items.
# Example 1 Input: $items1 = [ [1,1], [2,1], [3,2] ]
#                  $items2 = [ [2,2], [1,3] ]
#           Output: [ [1,4], [2,3], [3,2] ]
#   Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
#   Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
#   Item id (3) appears 1 time: [3,2]
# Example 2 Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
#                  $items2 = [ [3,1], [1,3] ]
#           Output: [ [1,8], [2,3], [3,3] ]
# Example 3 Input: $items1 = [ [1,1], [2,2], [3,3] ]
#                  $items2 = [ [2,3], [2,4] ]
#           Output: [ [1,1], [2,9], [3,3] ]
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub mergeItems($items1, $items2)
{
    my %merged;
    for my $list ( $items1, $items2 )
    {
        for my $kv ( $list->@* )
        {
            $merged{$kv->[0]} += $kv->[1];
        }
    }

    return [ map { [ $_, $merged{$_} ] } sort keys %merged ];
}

sub runTest
{
    use Test2::V0;

    my $items1; my $items2; my $expected;

    $items1 = [ [1,1], [2,1], [3,2] ];
    $items2 = [ [2,2], [1,3] ];
    $expected = [ [1,4], [2,3], [3,2] ];
    is( mergeItems($items1, $items2), $expected, "Example 1");

    $items1 = [ [1,2], [2,3], [1,3], [3,2] ];
    $items2 = [ [3,1], [1,3] ];
    $expected = [ [1,8], [2,3], [3,3] ];
    is( mergeItems($items1, $items2), $expected, "Example 2");

    $items1 = [ [1,1], [2,2], [3,3] ];
    $items2 = [ [2,3], [2,4] ];
    $expected = [ [1,1], [2,9], [3,3] ];
    is( mergeItems($items1, $items2), $expected, "Example 3");

    done_testing;
}
