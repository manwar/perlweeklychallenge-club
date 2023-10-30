#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Array Loops 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of unique integers.
# Write a script to determine how many loops are in the given array.
# To determine a loop: Start at an index and take the number at array[index]
# and then proceed to that index and continue this until you end up at the
# starting index.
# Example 1 Input: @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10)
#           Output: 3
#   To determine the 1st loop, start at index 0, the number at that
#   index is 4, proceed to index 4, the number at that index is 15,
#   proceed to index 15 and so on until you're back at index 0.
#   Loops are as below:
#   [4 15 1 6 13 5 0]
#   [3 8 7 18 9 16 12 17 2]
#   [14 11 19 10]
# Example 2 Input: @ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19)
#           Output: 6
#   [0]
#   [1]
#   [13 9 14 17 18 15 5 8 2]
#   [7 11 4 6 10 16 3]
#   [12]
#   [19]
# Example 3 Input: @ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17)
#           Output: 1
#   [9 4 5 7 19 17 15 1 8 12 18 6 13 2 3 11 10 14 16 0]
######
# The examples imply that the ints are actually a permutation of the
# indices 0..$#ints.  That means there will always be at least one loop,
# and every element will be part of a loop.
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say arrayLoops(@ARGV);

sub arrayLoops(@ints)
{
    my @isInAnyLoop = (false) x @ints;

    my $loopCount = 0;
    for ( my $start = 0 ; $start <= $#ints ; $start++ )
    {
        next if $isInAnyLoop[$start];

        my @visited = (false) x @ints;
        $visited[$start] = true;
        my @loop = ( $ints[$start] );

        my $next = $ints[$start];
        while ( ! $visited[$next] )
        {
            $isInAnyLoop[$next] = $visited[$next] = true;
            push @loop, $ints[$next] if $Verbose;
            $next = $ints[$next];
        }
        $loopCount++;
        say "LOOP: [@loop]" if $Verbose;
    }
    return $loopCount;
}

sub runTest
{
    use Test2::V0;

    is( arrayLoops( 4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10),
        3, "Example 1");
    is( arrayLoops( 0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19),
        6, "Example 2");
    is( arrayLoops( 9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17),
        1, "Example 3");

    done_testing;
}
