#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2024, Bob Lied
#=============================================================================
#  
# ch-2.pl Perl Weekly Challenge 251 Task 2 Lucky Numbers
#=============================================================================
# You are given a m x n matrix of distinct numbers.
# Write a script to return the lucky number, if there is one, or -1 if not.
# A lucky number is an element of the matrix such that it is
# the minimum element in its row and maximum in its column.
# Example 1 Input: $matrix = [ [ 3,  7,  8],
#                              [ 9, 11, 13],
#                              [15, 16, 17] ];
#           Output: 15
#   15 is the only lucky number since it is the minimum in its row
#   and the maximum in its column.
# Example 2 Input: $matrix = [ [ 1, 10,  4,  2],
#                              [ 9,  3,  8,  7],
#                              [15, 16, 17, 12] ];
#           Output: 12
# Example 3 Input: $matrix = [ [7 ,8], [1 ,2] ];
#           Output: 7
#=============================================================================

use v5.38;

use builtin qw/true false/; no warnings "experimental::builtin";

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

sub extremeIndex($row, $comparator)
{
    my $max = $row->[0];
    my $maxI = 0;
    while ( my ($i, $val) = each(@$row) )
    {
        ($maxI, $max) = ($i, $val) if ( $comparator->($val, $max) );
    }
    return $maxI;
}
sub maxIndex($row) { extremeIndex($row, sub { $_[0] > $_[1] }); }
sub minIndex($row) { extremeIndex($row, sub { $_[0] < $_[1] }); }

sub column($m, $col) { [ map { $_->[$col] } $m->@* ]; }

sub lucky($matrix)
{
    my @max = map { minIndex($_) } $matrix->@*;
    for my $rowNum ( 0 .. $#max )
    {
        if ( maxIndex( column($matrix, $max[$rowNum])) == $rowNum )
        {
            return $matrix->[$rowNum][$max[$rowNum]];
        }
    }
    return -1;
}

sub runTest
{
    use Test2::V0;

    is( maxIndex([4,5,6]), 2, "maxIndex last");
    is( maxIndex([6,4,2]), 0, "maxIndex first");
    is( maxIndex([6,9,2]), 1, "maxIndex middle");
    is( maxIndex([7    ]), 0, "maxIndex singleton");

    is( minIndex([6,5,4]), 2, "minIndex last");
    is( minIndex([2,4,6]), 0, "minIndex first");
    is( minIndex([6,1,2]), 1, "minIndex middle");
    is( minIndex([7    ]), 0, "minIndex singleton");

    my @matrix = ( [1,2,3], [4,5,6] );
    is( column(\@matrix, 0), [1,4], "column 0");
    is( column(\@matrix, 1), [2,5], "column 1");
    is( column(\@matrix, 2), [3,6], "column 2");

    my @case = ( [ "Example 1", 15, [ [ 3,  7,  8],
                                    [ 9, 11, 13],
                                    [15, 16, 17] ],
                 ],
                 [ "Example 2", 12, [ [ 1, 10,  4,  2],
                                      [ 9,  3,  8,  7],
                                      [15, 16, 17, 12] ],
                 ],
                 [ "Example 3",  7, [ [7 ,8],
                                      [1 ,2] ],
                 ],
                 [ "No such luck", -1, [ [  3,  6,  9 ],
                                         [  9, 15, 21 ],
                                         [ 17, 16, 15] ],
                 ],
);
    for my $tc ( @case )
    {
        is( lucky($tc->[2]), $tc->[1], $tc->[0] );
    }

    done_testing;
}
