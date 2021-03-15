#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl
#=============================================================================
# Copyright (c) 2021, Bob Lied
#=============================================================================
# Perl Weekly Challenge 101, Task #1  Pack a Spiral
# You are given an array @A of items (integers say, but they can be anything).
# Your task is to pack that array into an MxN matrix spirally counterclockwise,
# as tightly as possible.
# ‘Tightly’ means the absolute value |M-N| of the difference has to be as small
# as possible.
#
# Example 1: Input: @A = (1,2,3,4)
# Output: 4 3
#         1 2
# Since the given array is already a 1x4 matrix on its own, but that's not as
# tight as possible. Instead, you'd spiral it counterclockwise into
#
# Example 2: Input: @A = (1..6)
# Output: 6 5 4  OR  5 4
#         1 2 3      6 3
#                    1 2
# Either will do as an answer, because they're equally tight.
#=============================================================================

use strict;
use warnings;
use 5.020;
use experimental qw/signatures/;

use Getopt::Long;
my $doTest = 0;
my $verbose = 0;
GetOptions("test" => \$doTest, "verbose" => \$verbose);

exit(!runTest()) if $doTest;

# Take list from command line args
sub Usage() { "$0 n1 n2 n3 ..." };
my @A = @ARGV;
die "Need list, usage: ", Usage() unless @A;

showArray( packSpiral(\@A) );


sub packSpiral($A)
{
    my ($m, $n) = closestToSquare(scalar(@$A));
    return enSpiral(\@A, $m, $n);
}

# Return rows and columns that are closest rectangle to make an area of $n.
# If we list the factors of n in order, the median factors (the two closest
# to the center, or the middle if it's a perfect square) would be the ones.
# Another way of getting at it (and avoiding having to implement factorization)
# is to take the square root, find the first factor less than that, and use
# that to determine the factor above the square.  Worst case is that n is a
# large prime number.
sub closestToSquare($target)
{
    my $root = int(sqrt($target));
    my ($m, $n) = ($root, int($target / $root) );
    while ( $m*$n != $target ) { $n = int($target / --$m); }
    return ($m, $n);
}

sub showArray($a)
{
    say "[ ", join(" ", @$_), " ]" for @$a;
}

# Turn a list into a spiral around an array.  According to spec,
# start across the bottom, up the right, back across the top,
# down the left, etc.
#
#  V <- <- <-
#  V +V ->  ^
# .> -> -> ->
sub enSpiral($arr, $rows, $cols)
{
    my @spiral;
    my ($firstRow, $firstCol) = (0, 0);
    my ($lastRow, $lastCol) = ($rows-1, $cols-1);
    my ($r, $c) = (0, 0);

    for $r ( 0 .. $lastRow)
    {
        for $c ( $firstCol .. $lastCol )
        {
            $spiral[$r][$c] = '.'
        }
    }
    showArray(\@spiral) if $verbose;

    while ( @$arr )
    {
        # left to right along the bottom
        for ( $r = $lastRow, $c = $firstCol ; $c <= $lastCol ; $c++ )
        {
            $spiral[$r][$c] = shift @$arr;
        }
        last unless @$arr;
        $lastRow--;

        # bottom to top at right edge
        for ( $c = $lastCol, $r = $lastRow ; $r >= $firstRow ; $r-- )
        {
            $spiral[$r][$c] = shift @$arr;
        }
        last unless @$arr;
        $lastCol--;

        # right to left along the top
        for ( $r = $firstRow, $c = $lastCol ; $c >= $firstCol ; $c-- )
        {
            $spiral[$r][$c] = shift @$arr;
        }
        last unless @$arr;
        $firstRow++;

        # top to bottom along left edge
        for ( $c = $firstCol, $r = $firstRow ; $r <= $lastRow ; $r++ )
        {
            $spiral[$r][$c] = shift @$arr;
        }
        last unless @$arr;
        $firstCol++;
    }
    return \@spiral;
}

sub runTest
{
    use Test::More;

    my @dim;
    @dim = closestToSquare( 1); is_deeply(\@dim, [ 1,  1 ], "Factor  1: (@dim)" );
    @dim = closestToSquare( 2); is_deeply(\@dim, [ 1,  2 ], "Factor  2: (@dim)" );
    @dim = closestToSquare( 4), is_deeply(\@dim, [ 2,  2 ], "Factor  4: (@dim)" );
    @dim = closestToSquare( 6); is_deeply(\@dim, [ 2,  3 ], "Factor  6: (@dim)" );
    @dim = closestToSquare(12); is_deeply(\@dim, [ 3,  4 ], "Factor 12: (@dim)" );
    @dim = closestToSquare(92); is_deeply(\@dim, [ 4, 23 ], "Factor 92: (@dim)" );

    is_deeply( enSpiral( [ 1 ], 1, 1),   [ [ 1 ] ], "1x1");
    is_deeply( enSpiral( [ 1,2 ], 1, 2), [ [ 1,2 ] ], "1x2");
    is_deeply( enSpiral( [ 1,2,3,4 ], 2, 2), [ [4,3], [1,2] ], "2x2");
    is_deeply( enSpiral( [ 1,2,3,4,5,6 ], 2, 3), [ [6,5,4], [1,2,3] ], "2x3");
    is_deeply( enSpiral( [ 1,2,3,4,5,6,7,8,9,"a","b","c" ], 3, 4),
                            [ [9,8,7,6], ["a","b","c",5], [1,2,3,4] ], "3x4");

    is_deeply( enSpiral( [ 0..15 ], 4, 4),
        [ [9,8,7,6], [10,15,14, 5], [11,12,13,4],[0,1,2,3] ], "4x4");


    done_testing;
}
