#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 271 Task 1 Maximum Ones
#=============================================================================
# You are given a m x n binary matrix.
# Write a script to return the row number containing maximum ones,
# in case of more than one rows then return smallest row number.
# Example 1 Input: $matrix = [ [0, 1], [1, 0], ]
#           Output: 1
#   Row 1 and Row 2 have the same number of ones, so return row 1.
# Example 2 Input: $matrix = [ [0, 0, 0], [1, 0, 1], ]
#           Output: 2
# Example 3 Input: $matrix = [ [0, 0], [1, 1], [0, 0], ]
#           Output: 2
#=============================================================================

use v5.38;

use List::Util qw/sum/;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub maxOnes($matrix)
{
    my $most = 0;
    my $mostRow = 0;
    for my $row ( 0 .. $matrix->$#* )
    {
        my $count = sum $matrix->[$row]->@*;
        if ( $count > $most )
        {
            $most = $count;
            $mostRow = $row+1;
        }
    }
    return $mostRow;
}

sub runTest
{
    use Test2::V0;

    is( maxOnes([ [0,1], [1,0] ]), 1, "Example 1");
    is( maxOnes([ [0,0,0], [1,0,1] ]), 2, "Example 2");
    is( maxOnes([ [0,0],[1,1],[0,0] ]), 2, "Example 3");

    done_testing;
}
