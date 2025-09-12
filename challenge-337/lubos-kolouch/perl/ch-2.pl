#!/usr/bin/env perl
use strict;
use warnings;

# Task 2: Odd Matrix
#
# You are given `row` and `col`, also a list of positions in the matrix.
#
# Write a script to perform action on each location (0-indexed) as provided in the list and find out the total odd valued cells.
#
# For each location (r, c), do both of the following:
# a) Increment by 1 all the cells on row r.
# b) Increment by 1 all the cells on column c.
#
# Example 1
# Input: $row = 2, $col = 3, @locations = ([0,1],[1,1])
# Output: 6
#
# Example 2
# Input: $row = 2, $col = 2, @locations = ([1,1],[0,0])
# Output: 0
#
# Example 3
# Input: $row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])
# Output: 0

sub odd_matrix {
    my ( $row, $col, $locations ) = @_;
    my @matrix;

    # Initialize matrix
    for my $i ( 0 .. $row - 1 ) {
        for my $j ( 0 .. $col - 1 ) {
            $matrix[$i][$j] = 0;
        }
    }

    # Increment rows and columns
    for my $loc (@$locations) {
        my ( $r, $c ) = @$loc;
        for my $i ( 0 .. $col - 1 ) {
            $matrix[$r][$i]++;
        }
        for my $i ( 0 .. $row - 1 ) {
            $matrix[$i][$c]++;
        }
    }

    # Count odd cells
    my $odd_cells = 0;
    for my $i ( 0 .. $row - 1 ) {
        for my $j ( 0 .. $col - 1 ) {
            if ( $matrix[$i][$j] % 2 != 0 ) {
                $odd_cells++;
            }
        }
    }

    return $odd_cells;
}

use Test::More;

is( odd_matrix( 2, 3, [ [ 0, 1 ], [ 1, 1 ] ] ),                     6, 'Example 1' );
is( odd_matrix( 2, 2, [ [ 1, 1 ], [ 0, 0 ] ] ),                     0, 'Example 2' );
is( odd_matrix( 3, 3, [ [ 0, 0 ], [ 1, 2 ], [ 2, 1 ] ] ),           0, 'Example 3' );
is( odd_matrix( 1, 5, [ [ 0, 2 ], [ 0, 4 ] ] ),                     2, 'Example 4' );
is( odd_matrix( 4, 2, [ [ 1, 0 ], [ 3, 1 ], [ 2, 0 ], [ 0, 1 ] ] ), 8, 'Example 5' );

done_testing();
