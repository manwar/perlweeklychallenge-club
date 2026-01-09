#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 354 Task 2: Shift Grid
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub shift_grid( $matrix, $k ) {
    my @array = map $_->@*, $matrix->@*;
    unshift @array, splice( @array, -( $k % @array ) );
    my ( $i, $w ) = ( 0, scalar $matrix->[0]->@* );
    return map { $i += $w; [ @array[ $i - $w .. $i - 1 ] ] } keys $matrix->@*;
}

use Test2::V0 qw( -no_srand );

is [ shift_grid( [[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1 ) ],
    [ [9, 1, 2], [3, 4, 5], [6, 7, 8] ],
    'Example 1: shift_grid( [[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1 )'
        . ' == ([9, 1, 2], [3, 4, 5], [6, 7, 8])';
is [ shift_grid( [[10, 20], [30, 40]], 1 ) ],
    [ [40, 10], [20, 30] ],
    'Example 2: shift_grid( [[10, 20], [30, 40]], 1 ) == ([40, 10], [20, 30])';
is [ shift_grid( [[1, 2], [3, 4], [5, 6]], 1 ) ],
    [ [6, 1], [2, 3], [4, 5] ],
    'Example 3: shift_grid( [[1, 2], [3, 4], [5, 6]], 1 )'
        . ' == ([6, 1], [2, 3], [4, 5])';
is [ shift_grid( [[1, 2, 3], [4, 5, 6]], 5 ) ],
    [ [2, 3, 4], [5, 6, 1] ],
    'Example 4: shift_grid( [[1, 2, 3], [4, 5, 6]], 5 )'
        . ' == ([2, 3, 4], [5, 6, 1])';
is [ shift_grid( [[1 .. 4]], 1 ) ], [ [4, 1, 2, 3] ],
    'Example 5: shift_grid( [[1 .. 4]], 1 ) == [4, 1, 2, 3]';

done_testing;
