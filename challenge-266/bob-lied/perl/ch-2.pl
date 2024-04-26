#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 266 Task 2 X Matrix
#=============================================================================
# You are given a square matrix, $matrix.
# Write a script to find if the given matrix is X Matrix.
# A square matrix is an X Matrix if all the elements on the main diagonal
# and antidiagonal are non-zero and everything else are zero.
#
# Example 1 Input: $matrix = [ [1, 0, 0, 2],
#                              [0, 3, 4, 0],
#                              [0, 5, 6, 0],
#                              [7, 0, 0, 1], ]
#           Output: true
# Example 2 Input: $matrix = [ [1, 2, 3],
#                              [4, 5, 6],
#                              [7, 8, 9], ]
#           Output: false
# Example 3 Input: $matrix = [ [1, 0, 2],
#                              [0, 3, 0],
#                              [4, 0, 5], ]
#           Output: true
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

use List::Util qw/all/;
sub isZero(@elem)    { return all { $_ == 0 } @elem; }
sub isNonZero(@elem) { return all { $_ != 0 } @elem; }

# Exploit the symmetry. Given $r and $c in one quadrant, return
# the four values from all four quadrants
sub symElem($m, $end, $r, $c)
{
    return ( $m->[$r][$c],
             $m->[$r][$end - $c],
             $m->[$end - $r][$c],
             $m->[$end - $r][$end - $c] )
}

sub xmatrix($matrix)
{
    my $end = $matrix->[0]->$#*;
    my $mid  = int($end / 2);

    my $isX = true;
    for my $r ( 0 .. $mid )
    {
        for my $c ( 0 .. $mid )
        {
            $isX &&= ( $r == $c )
                     ? isNonZero( symElem($matrix, $end, $r, $c) )
                     : isZero(    symElem($matrix, $end, $r, $c) )
                     ;
        }
    }
    return $isX;
}

sub runTest
{
    use Test2::V0;
use builtin qw/true false/; no warnings "experimental::builtin";

    my $matrix;

    $matrix = [ [1, 0, 0, 2],
                [0, 3, 4, 0],
                [0, 5, 6, 0],
                [7, 0, 0, 1], ];
    is(xmatrix($matrix), true, "Example 1");

    $matrix = [ [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9], ];
    is(xmatrix($matrix), false, "Example 2");

    $matrix = [ [1, 0, 2],
                [0, 3, 0],
                [4, 0, 5], ];
    is(xmatrix($matrix), true, "Example 3");

    $matrix = [ [0, 0, 2],
                [0, 3, 0],
                [4, 0, 5], ];
    is(xmatrix($matrix), false, "Example 3 but false");

    $matrix = [ [1, 2],
                [3, 4], ];
    is(xmatrix($matrix), true, "2x2 true");

    $matrix = [ [1, 0],
                [3, 4], ];
    is(xmatrix($matrix), false, "2x2 false");

    $matrix = [ [1] ];
    is(xmatrix($matrix), true, "1x1 true");
    $matrix = [ [0] ];
    is(xmatrix($matrix), false, "1x1 false");

    $matrix = [ [1, 0, 0, 2],
                [0, 3, 4, 0],
                [0, 5, 6, 0],
                [7, 0, 0, 8], ];
    is(xmatrix($matrix), true, "4x4 true");

    $matrix->[0][1] = 9;
    is(xmatrix($matrix), false, "4x4 q1 false");

    $matrix->[0][1] = 0;
    $matrix->[1][3] = 9;
    is(xmatrix($matrix), false, "4x4 q2 false");

    $matrix->[1][3] = 0;
    $matrix->[0][2] = 9;
    is(xmatrix($matrix), false, "4x4 q3 false");

    $matrix->[0][2] = 0;
    $matrix->[2][3] = 9;
    is(xmatrix($matrix), false, "4x4 q4 false");

    $matrix = [ [1, 0, 0, 0, 2],
                [0, 3, 0, 4, 0],
                [0, 0, 5, 0, 0],
                [0, 6, 0, 7, 0],
                [8, 0, 0, 0, 9], ];
    is(xmatrix($matrix), true, "5x5 true");

    $matrix->[0][1] = 9;
    is(xmatrix($matrix), false, "5x5 q1 false");

    $matrix->[0][1] = 0;
    $matrix->[1][4] = 9;
    is(xmatrix($matrix), false, "5x5 q2 false");

    $matrix->[1][4] = 0;
    $matrix->[3][0] = 9;
    is(xmatrix($matrix), false, "5x5 q3 false");

    $matrix->[3][0] = 0;
    $matrix->[4][1] = 9;
    is(xmatrix($matrix), false, "5x5 q4 false");

    $matrix->[4][1] = 0;
    $matrix->[1][2] = 9;
    is(xmatrix($matrix), false, "5x5 vertical false");

    $matrix->[1][2] = 0;
    $matrix->[2][1] = 9;
    is(xmatrix($matrix), false, "5x5 horizontal false");

    done_testing;
}
