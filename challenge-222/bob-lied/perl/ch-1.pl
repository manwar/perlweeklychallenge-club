#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge 222 Task 1 Matching Members 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of positive integers, @ints.
# Write a script to find the total matching members after sorting the list
# increasing order. That is, the number of elements that are already in
# their sorted position.
# Example 1 Input: @ints = (1, 1, 4, 2, 1, 3)
#          Output: 3
#   Original list: (1, 1, 4, 2, 1, 2)
#   Sorted list  : (1, 1, 1, 2, 3, 4)
#   Compare the two lists, we found 3 matching members (1, 1, 2).
# Example 2 Input: @ints = (5, 1, 2, 3, 4)
#          Output: 0
#   Original list: (5, 1, 2, 3, 4)
#   Sorted list  : (1, 2, 3, 4, 5)
#   Compare the two lists, we found 0 matching members.
# Example 3 Input: @ints = (1, 2, 3, 4, 5)
#          Output: 5
#   Original list: (1, 2, 3, 4, 5)
#   Sorted list  : (1, 2, 3, 4, 5)
#   Compare the two lists, we found 5 matching members.
#  
#=============================================================================

use v5.36;

use FindBin qw($Bin);
use lib "$FindBin::Bin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub matchingMembers($list)
{
    my @sorted = sort { $a <=> $b } @$list;

    grep { $list->[$_] == $sorted[$_] } ( 0 .. $list->$#* )
}

sub runTest
{
    use Test2::V0;

    is( matchingMembers( [1,1,4,2,1,3] ), 3, "Example 1");
    is( matchingMembers( [5,1,2,3,4  ] ), 0, "Example 2");
    is( matchingMembers( [1,2,3,4,5  ] ), 5, "Example 3");

    done_testing;
}

