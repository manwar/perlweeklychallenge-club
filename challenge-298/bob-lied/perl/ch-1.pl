#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
# ch-1.pl Perl Weekly Challenge 298 Task Maximal Square
#=============================================================================
# <+Description+>
#=============================================================================
#=============================================================================
# You are given an m x n binary matrix with 0 and 1 only.
# Write a script to find the largest square containing only 1's
# and return it’s area.
# Example 1 Input: @matrix = ([1, 0, 1, 0, 0],
#                             [1, 0, 1, 1, 1],
#                             [1, 1, 1, 1, 1],
#                             [1, 0, 0, 1, 0])
#           Output: 4
#   Two maximal square found with same size marked as 'x':
#   [1, 0, 1, 0, 0]     [1, 0, 1, 0, 0]
#   [1, 0, x, x, 1]     [1, 0, 1, x, x]
#   [1, 1, x, x, 1]     [1, 1, 1, x, x]
#   [1, 0, 0, 1, 0]     [1, 0, 0, 1, 0]
#
# Example 2 Input: @matrix = ([0, 1], [1, 0])
#           Output: 1
# Example 3 Input: @matrix = ([0])
#           Output: 0
#=============================================================================

use v5.40;
use List::Util qw/all min/;

use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;
my $Benchmark = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose, "benchmark:i" => \$Benchmark);
exit(!runTest()) if $DoTest;
exit( runBenchmark($Benchmark) ) if $Benchmark;

my @matrix;
for my $row (@ARGV)
{
    push @matrix, [ split(" ", trim($row =~ s/[^01]+/ /gr)) ];
}
say maxSquare(\@matrix);

sub maxSquare($matrix)
{
    my $height = $matrix->$#*;
    my $width  = $matrix->[0]->$#*;

    my $box = min($height, $width);

    my $max = 0;
    for ( my $ulRow = 0; $ulRow <= $height; $ulRow++ )
    {
        for (my $ulCol = 0; $ulCol <= $width; $ulCol++ )
        {
            next if $matrix->[$ulRow][$ulCol] == 0; # Find a 1 in this row

            # Check all possible squares that begin from this corner.
            # Only need to check those that might be larger than known max.
            for my $side ( $max .. $box )
            {
                next if ( $ulRow + $side > $height || $ulCol + $side > $width );
                if ( isAllOne($matrix, $ulRow, $ulCol, $ulRow+$side, $ulCol+$side) )
                {
                    $max = $side+1;
                    if ($Verbose) { say "isAllOne(matrix, $ulRow,$ulCol, ", $ulRow+$side,", ",  $ulCol+$side, ") -> max=$max" }
                }
            }
        }
    }
    return $max*$max;
}

sub isAllOne($matrix, $ulRow, $ulCol, $lrRow, $lrCol)
{
    my $one = true;
    for my $r ( $ulRow .. $lrRow )
    {
        my @line = $matrix->[$r]->@[$ulCol .. $lrCol];
        $one &&= all { $_ == 1 } @line;
        last if !$one;
    }
    return $one;
}

sub runTest
{
    use Test2::V0;

    my @matrix = ( [1,0,1,0,0],[1,0,1,1,1],[1,1,1,1,1],[1,0,0,1,0]);
    is( isAllOne(\@matrix, 0,0, 0,0), true, "isAllOne cell yes");
    is( isAllOne(\@matrix, 0,1, 0,1), false, "isAllOne cell no");
    is( isAllOne(\@matrix, 1,0, 2,2), false, "isAllOne rectangle no");
    is( isAllOne(\@matrix, 1,2, 2,4), true, "isAllOne rectangle yes");

    is( maxSquare(\@matrix), 4, "Example 1");

    @matrix = ( [0,1], [1,0] );
    is( maxSquare(\@matrix), 1, "Example 2");

    @matrix = ( [0] );
    is( maxSquare(\@matrix), 0, "Example 3");

    @matrix = ( [1,1,1], [1,1,1], [1,1,1] );
    is( maxSquare(\@matrix), 9, "Whole thing");

    @matrix = ( [0,0,0,0,0],[0,1,1,1,0],[0,1,1,1,0],[0,1,1,1,0],[0,0,0,0,0] );
    is( maxSquare(\@matrix), 9, "Middle");

    done_testing;
}

sub runBenchmark($repeat)
{
    use Benchmark qw/cmpthese/;

    cmpthese($repeat, {
            label => sub { },
        });
}
