#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-1.pl Perl Weekly Challenge 270 Task 1 Special Positions
#=============================================================================
# You are given a m x n binary matrix.
# Write a script to return the number of special positions in the given
# binary matrix.  A position (i, j) is called special if
# $matrix[i][j] == 1 and all other elements in the row i and column j are 0.
# Example 1 Input: $matrix = [ [1, 0, 0],
#                              [0, 0, 1],
#                              [1, 0, 0], ]
#           Output: 1
#   There is only one special position (1, 2) as $matrix[1][2] == 1
#   and all other elements in row 1 and column 2 are 0.
# Example 2 Input: $matrix = [ [1, 0, 0],
#                              [0, 1, 0],
#                              [0, 0, 1], ]
#           Output: 3
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Extract a column from a matrix
sub columnOf($matrix, $col)
{
    map { $_->[$col] } $matrix->@*;
}

# Extract the column above a row, not including the row
sub above($matrix, $row, $col)
{
    map { $_->[$col] } $matrix->@[0 .. $row-1];
}

# Extract the column below a row, not including the row
sub below($matrix, $row, $col)
{
    map { $_->[$col] } $matrix->@[$row+1 .. $matrix->$#*];
}

sub specialPos($matrix)
{
    use List::Util qw/sum all/;
    use List::MoreUtils qw/indexes/;

    my $special = 0;

    for ( 0 .. $matrix->$#* )
    {
        my @ones = indexes { $_ == 1 } $matrix->[$_]->@*;

        $special++ if ( @ones == 1 )
                   && ( all { $_ == 0 } above($matrix, $_, $ones[0]) )
                   && ( all { $_ == 0 } below($matrix, $_, $ones[0]) );
    }

    return $special;
}

sub runTest
{
    use Test2::V0;

    my $matrix = [ [1,0,0], [0,0,1], [1,0,0] ];
    is( [ above($matrix, 0, 0) ], [], "Above 0,0");
    is( [ above($matrix, 1, 0) ], [ 1 ], "Above 1,0");
    is( [ above($matrix, 2, 0) ], [ 1, 0 ], "Above 2,0");
    is( [ below($matrix, 0, 1) ], [ 0, 0 ], "Below 0,0");
    is( [ below($matrix, 1, 1) ], [ 0 ], "Below 1,0");
    is( [ below($matrix, 2, 1) ], [ ], "Below 2,0");
    is( [ below($matrix, 2, 2) ], [ ], "Below 2,2");

    is( specialPos($matrix), 1, "Example 1");

    $matrix = [ [1,0,0], [0,1,0], [0,0,1] ];
    is( specialPos($matrix), 3, "Example 2");

    $matrix = [ [0,0,0,0], [0,0,0,0] ];
    is( specialPos($matrix), 0, "All zero");

    $matrix = [ [1,1,1,1], [1,1,1,1], [1,1,1,1] ];
    is( specialPos($matrix), 0, "All one");

    $matrix = [ [0,0], [1,0], [0,0], [1,1] ];
    is( specialPos($matrix), 0, "row > col");

    $matrix = [ [0,0], [1,0], [0,0], [0,0] ];
    is( specialPos($matrix), 1, "row > col, with special");

    $matrix = [ [1] ];
    is( specialPos($matrix), 1, "degenerate 1x1 with 1");

    $matrix = [ [0] ];
    is( specialPos($matrix), 0, "degenerate 1x1 with 0");

    $matrix = [ [0,0,0] ];
    is( specialPos($matrix), 0, "one row, 0");

    $matrix = [ [0,1,0] ];
    is( specialPos($matrix), 1, "one row, 1");

    $matrix = [ [1,1,0] ];
    is( specialPos($matrix), 0, "one row, 2");

    $matrix = [ [1], [0], [0], [0] ];
    is( specialPos($matrix), 1, "one col, 1");

    done_testing;
}
