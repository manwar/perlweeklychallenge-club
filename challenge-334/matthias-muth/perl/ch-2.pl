#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 334 Task 2: Nearest Valid Point
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( indexed );

sub nearest_valid_point_traditional( $x, $y, $points ) {
    my ( $closest_index, $closest_distance ) = ( undef, undef );
    for my ( $index, $point ) ( indexed $points->@* ) {
        my $distance =
            $point->[0] == $x   ? abs( $y - $point->[1] )
            : $point->[1] == $y ? abs( $x - $point->[0] )
            : next;
        ( $closest_index, $closest_distance ) = ( $index, $distance )
            if ! defined $closest_index || $distance < $closest_distance;
    }
    return $closest_index // -1;
}

use List::UtilsBy qw( min_by );

sub nearest_valid_point( $x, $y, $points ) {
    my $closest_index =
        min_by { abs( $points->[$_][0] - $x ) + abs( $points->[$_][1] - $y ) }
            grep $points->[$_][0] == $x || $points->[$_][1] == $y,
                keys $points->@*;
    return $closest_index // -1;
}

use Test2::V0 qw( -no_srand );

is nearest_valid_point( 3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]] ), 2,
    'Example 1: nearest_valid_point( 3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]] ) == 2';
is nearest_valid_point( 2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]] ), 3,
    'Example 2: nearest_valid_point( 2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]] ) == 3';
is nearest_valid_point( 1, 1, [[2, 2], [3, 3], [4, 4]] ), -1,
    'Example 3: nearest_valid_point( 1, 1, [[2, 2], [3, 3], [4, 4]] ) == -1';
is nearest_valid_point( 0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]] ), 0,
    'Example 4: nearest_valid_point( 0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]] ) == 0';
is nearest_valid_point( 5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]] ), 0,
    'Example 5: nearest_valid_point( 5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]] ) == 0';

done_testing;
