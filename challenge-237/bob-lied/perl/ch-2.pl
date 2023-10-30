#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 237 Task 2 Maximise Greatness 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given an array of integers.
# Write a script to permute the give array such that you get the
# maximum possible greatness.
# To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length
#
# Example 1 Input: @nums = (1, 3, 5, 2, 1, 3, 1)
#           Output: 4
#   One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns
#   4 greatness as below:
#      [1] [3] 5 [2] [1] 3  1
#       <   <  .  <   <  .  .
#      [2] [5] 1 [3] [3] 1  1
#
# Example 2 Input: @ints = (1, 2, 3, 4)
#           Output: 3
#   One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
#       [1] [2] [3]  4
#        <   <   <   .
#       [2] [3] [4]  1
#
# If we sort the list, we can match the smallest number with the first
# one that achieves greatness, and then move right 
#
#    1    1    1    2    3    3    5
#    +--------------^
#         +--------------^
#              +--------------+
#                   +--------------^
#
#    1    1    1    2    3    3    5    7    8    9
#    +--------------^
#         +--------------^
#              +--------------+
#                   +--------------^
#                        +--------------^
#                             +---------------^
#                                  +---------------^
#=============================================================================

use v5.38;
use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say maximizeGreatness(@ARGV);

sub maximizeGreatness(@nums)
{
    my $greatness = 0;

    # Work in a sorted array.
    my @num = sort { $a <=> $b } @nums;

    my $small = 0;
    my $big = 0;

    while ( ++$big <= $#num )
    {
        # Advance until we find a bigger number to pair with
        if ( $num[$big] > $num[$small] )
        {
            say "Found num[$small], num[$big] = $num[$small], $num[$big]" if $Verbose;
            $greatness++;
            $small++;   # Move on to next smaller number
        }
    }
    return $greatness;
}

sub runTest
{
    use Test2::V0;

    is( maximizeGreatness(1,3,5,2,1,3,1), 4, "Example 1");
    is( maximizeGreatness(1,2,3,4      ), 3, "Example 2");

    is( maximizeGreatness(             ), 0, "Empty array");
    is( maximizeGreatness( 20          ), 0, "One element");
    is( maximizeGreatness( 1,1,1,1     ), 0, "Opposite of great");
    is( maximizeGreatness( 3,20,100    ), 2, "Bigger numbers, sort check");

    done_testing;
}
