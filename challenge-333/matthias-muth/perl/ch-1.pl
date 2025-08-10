#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 333 Task 1: Straight Line
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );

use List::Util qw( all );

sub dx_dy( $p1, $p2 ) {
    return ( $p2->[0] - $p1->[0], $p2->[1] - $p1->[1] );
}

sub straight_line( $list ) {
    my ( $dx_1, $dy_1 ) = dx_dy( $list->[0], $list->[1] );
    return all {
        my ( $dx, $dy ) = dx_dy( $list->[0], $list->[$_] );
        $dx_1 == 0 && $dy_1 == 0
            ? do { ( $dx_1, $dy_1 ) = ( $dx, $dy ); true }
            : $dx_1 * $dy == $dy_1 * $dx;
    } 2 .. $list->$#*;
}

use Test2::V0 qw( -no_srand );

is straight_line( [[2, 1], [2, 3], [2, 5]] ), T,
    'Example 1: straight_line( [[2, 1], [2, 3], [2, 5]] ) is true';
is straight_line( [[1, 4], [3, 4], [10, 4]] ), T,
    'Example 2: straight_line( [[1, 4], [3, 4], [10, 4]] ) is true';
is straight_line( [[0, 0], [1, 1], [2, 3]] ), F,
    'Example 3: straight_line( [[0, 0], [1, 1], [2, 3]] ) is false';
is straight_line( [[1, 1], [1, 1], [1, 1]] ), T,
    'Example 4: straight_line( [[1, 1], [1, 1], [1, 1]] ) is true';
is straight_line( [[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]] ), T,
    'Example 5: straight_line( [[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]] ) is true';

is straight_line( [[1, 1], [1, 1], [2, 2]] ), T,
    'Test 1: straight_line( [[1, 1], [1, 1], [2, 2]] ) is true';
is straight_line( [[1, 1], [1, 1], [2, 2], [3, 3]] ), T,
    'Test 2: straight_line( [[1, 1], [1, 1], [2, 2], [3, 3]] ) is true';
is straight_line( [[1, 1], [1, 1], [2, 2], [3, 3], [4, 5]] ), F,
    'Test 3: straight_line( [[1, 1], [1, 1], [2, 2], [3, 3], [4, 5]] ) is false';

done_testing;
