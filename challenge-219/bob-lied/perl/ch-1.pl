#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Task 1 Sorted Squares 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of numbers.
# Write a script to square each number in the list and return the sorted
# list, increasing order.
# Example 1 Input: @list = (-2, -1, 0, 3, 4) Output: (0, 1, 4, 9, 16)
# Example 2 Input: @list = (5, -4, -1, 3, 6) Output: (1, 9, 16, 25, 36)
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

say "(", join(", ", sortedSquares(@ARGV)->@*), ")";

sub sortedSquares(@numList)
{
    [ sort { $a <=> $b } map { $_*$_ } @numList ];
}

sub runTest
{
    use Test2::V0;

    is( sortedSquares(-2,-1,0,3,4), [0,1,4,9,16], "Exmple 1");
    is( sortedSquares(5,-4,-1,3,6), [1,9,16,25,36], "Exmple 1");

    done_testing;
}
