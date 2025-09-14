#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 338 Task 2: Max Distance
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::SomeUtils qw( minmax );
use List::Util qw( max );

sub max_distance( $arr1, $arr2 ) {
    my ( $arr1_min, $arr1_max ) = minmax $arr1->@*;
    my ( $arr2_min, $arr2_max ) = minmax $arr2->@*;
    return max( $arr2_max - $arr1_min, $arr1_max - $arr2_min );
}

use Test2::V0 qw( -no_srand );

is max_distance( [4, 5, 7], [9, 1, 3, 4] ), 6,
    'Example 1: max_distance( [4, 5, 7], [9, 1, 3, 4] ) == 6';
is max_distance( [2, 3, 5, 4], [3, 2, 5, 5, 8, 7] ), 6,
    'Example 2: max_distance( [2, 3, 5, 4], [3, 2, 5, 5, 8, 7] ) == 6';
is max_distance( [2, 1, 11, 3], [2, 5, 10, 2] ), 9,
    'Example 3: max_distance( [2, 1, 11, 3], [2, 5, 10, 2] ) == 9';
is max_distance( [1, 2, 3], [3, 2, 1] ), 2,
    'Example 4: max_distance( [1, 2, 3], [3, 2, 1] ) == 2';
is max_distance( [1, 0, 2, 3], [5, 0] ), 5,
    'Example 5: max_distance( [1, 0, 2, 3], [5, 0] ) == 5';

done_testing;
