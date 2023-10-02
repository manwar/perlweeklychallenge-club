#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge 218 Task 2 Matrix Score 
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a m x n binary matrix i.e. having only 1 and 0.
# You are allowed to make as many moves as you want to get the highest score.
# A move can be either toggling each value in a row or column.
# To get the score, convert the each row binary to dec and return the sum.
# Example 1: Input: @matrix = [ [0,0,1,1],
#                               [1,0,1,0],
#                               [1,1,0,0], ]
#           Output: 39
#   Move #1: convert row #1 => 1100
#         [ [1,1,0,0],
#           [1,0,1,0],
#           [1,1,0,0], ]
#   Move #2: convert col #3 => 101
#         [ [1,1,1,0],
#           [1,0,0,0],
#           [1,1,1,0], ]
#   Move #3: convert col #4 => 111
#         [ [1,1,1,1],
#           [1,0,0,1],
#           [1,1,1,1], ]
#   Score: 0b1111 + 0b1001 + 0b1111 => 15 + 9 + 15 => 39
#
# Example 2: Input: @matrix = [ [0] ]
#           Output: 1
# -------------------
# The maximum score would be if we could turn all the zeroes into ones.
# All the highest bits should be a one, so first toggle any row with
# a leading zero.
# To get the maximum number of ones, toggle any column (other than the
# first) where the number of zeroes is currently less than the number of ones.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Toggling a 1 to 0 or vice versa by negation doesn't work as desired.
# Although !0 == 1, it turns out that !1 == '' -- logically false but
# numerically useless.  However, there is a quirk of the oct() function
# that it will convert an empty string to 0.
sub toggle($b) { oct(!$b) }

sub toggleRow($row)
{
    $row->[$_] = toggle($row->[$_]) for 0 .. $row->$#*
}

sub toggleColumn($matrix, $col)
{
    for my $row ( $matrix->@* )
    {
        $row->[$col] = toggle($row->[$col]);
    }
}

sub countColZero($matrix, $col)
{
    my $zero = grep { $_->[$col] == 0 } $matrix->@*;
    return $zero;
}

# The oct() function is also useful because it understands the integer
# prefixes 0, 0x, and 0b (octal, hex, and binary).
sub score($matrix)
{
    use List::Util qw(sum);
    my @val = map { oct("0b" . join("", $_->@*)) } @$matrix;
    return sum @val;
}

sub matrixScore($matrix)
{
    # Get dimensions of the matrix (0-based)
    my $m = $matrix->$#*;
    my $n = $#{$matrix->[0]};

    # First, every row should start with a 1
    for my $row ( $matrix->@* )
    {
        toggleRow($row) if ( $row->[0] == 0 );
    }

    # Second, toggle a column if it has more zeroes than ones.
    for my $col ( 1 .. $n )
    {
        my $zero = countColZero($matrix, $col);
        toggleColumn($matrix, $col) if $zero > (($m+1)/2);
    }
    return score($matrix);
}

sub runTest
{
    use Test2::V0;

    is( score( [ [0] ] ), 0, "Score 0");
    is( score( [ [1] ] ), 1, "Score 1");

    is( matrixScore( [ [0] ] ), 1, "Example 2");
    is( matrixScore( [ [0,0,1,1], [1,0,1,0], [1,1,0,0] ] ), 39, "Example 1");
    is( matrixScore( [ [0,0,0,0], [0,0,0,0], [0,0,0,0] ] ), 45, "All zero");
    is( matrixScore( [ [1,1,1,1], [1,1,1,1], [1,1,1,1] ] ), 45, "All one");
    is( matrixScore( [ [1,0,0], [0,1,0], [0,0,1] ] ), 18, "Diagonal one");
    is( matrixScore( [ [0,1,1], [1,0,1], [1,1,0] ] ), 18, "Diagonal zero");
    is( matrixScore( [ [1,0,1,0], [0,1,0,1], [1,0,1,0] ] ), 45, "Checkerboard");

    done_testing;
}

