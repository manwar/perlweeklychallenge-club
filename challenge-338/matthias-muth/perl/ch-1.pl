#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 338 Task 1: Highest Row
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum max );

sub highest_row( $matrix ) {
    return max( map sum( $_->@* ), $matrix->@* );
}

use Test2::V0 qw( -no_srand );

is highest_row( [[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]] ), 16,
    'Example 1: highest_row( [[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]] ) == 16';
is highest_row( [[1, 5], [7, 3], [3, 5]] ), 10,
    'Example 2: highest_row( [[1, 5], [7, 3], [3, 5]] ) == 10';
is highest_row( [[1, 2, 3], [3, 2, 1]] ), 6,
    'Example 3: highest_row( [[1, 2, 3], [3, 2, 1]] ) == 6';
is highest_row( [[2, 8, 7], [7, 1, 3], [1, 9, 5]] ), 17,
    'Example 4: highest_row( [[2, 8, 7], [7, 1, 3], [1, 9, 5]] ) == 17';
is highest_row( [[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]] ), 100,
    'Example 5: highest_row( [[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]] ) == 100';

done_testing;
