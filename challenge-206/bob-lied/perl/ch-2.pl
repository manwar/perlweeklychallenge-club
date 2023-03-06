#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 206 Task 2 Array Pairings
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers having even number of elements.
# Write a script to find the maximum sum of the minimum of each pairs.
# Example 1 Input: @array = (1,2,3,4) Output: 4
#   Possible Pairings are as below:
#   a) (1,2) and (3,4). So min(1,2) + min(3,4) => 1 + 3 => 4
#   b) (1,3) and (2,4). So min(1,3) + min(2,4) => 1 + 2 => 3
#   c) (1,4) and (2,3). So min(1,4) + min(2,3) => 2 + 1 => 3
#   So the maxium sum is 4.
#
# Example 2 Input: @array = (0,2,1,3) Output: 2
#   Possible Pairings are as below:
#   a) (0,2) and (1,3). So min(0,2) + min(1,3) => 0 + 1 => 1
#   b) (0,1) and (2,3). So min(0,1) + min(2,3) => 0 + 2 => 2
#   c) (0,3) and (2,1). So min(0,3) + min(2,1) => 0 + 1 => 1
#   So the maximum sum is 2.
#
# The eager programer immediately jumps to a literal interpretation
# and generates all pairs, then reduces the list by adding all
# possible pairs.
#
# But this is more of a brain-teaser than a programming challenge.
# After looking at a couple of examples, you notice that the maximum
# sum is the sum of the largest numbers in the list that could be
# selected.
#
# If we sort the list descending, then the first four numbers will be the
# two pairs with the largest values, and the maximum sum is elements 1 plus 3.
#   a  >  b  >  c  >  d  > ...
#   min(a,b) + min(c,d)
#      b     +    d
#
# The examples show lists with only two pairs, so I originally made a bad
# assumption that the answer was the sum of the two largest pairs.  But the
# description actually says "sum of of the minimum of each pair."  So it's
# not just the first two pairs in the sort, but the sum of the minima of
# all the pairs in the sort.
#=============================================================================

use v5.36;

use List::Util qw/sum/;

use Getopt::Long;
my $DoTest  = 0;

GetOptions("test" => \$DoTest);
exit(!runTest()) if $DoTest;

say arrayPairs(\@ARGV);

sub arrayPairs($list)
{
    my @oddIndex = map { $_ * 2 + 1 } 0 .. int( $#{$list} / 2 );
    return sum(  (sort { $b <=> $a } $list->@*)[@oddIndex] );
}


sub runTest
{
    use Test2::V0;

    is( arrayPairs([1,2,3,4]), 4, "Example 1");
    is( arrayPairs([0,2,1,3]), 2, "Example 1");

    is( arrayPairs([3,3,3,3]), 6, "All same");
    is( arrayPairs([1,2,3,4,5,6,7,8]), 16, "1..8");

    done_testing;
}
