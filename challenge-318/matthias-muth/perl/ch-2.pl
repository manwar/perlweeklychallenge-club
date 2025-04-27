#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 318 Task 2: Reverse Equals
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( all first );

sub reverse_equals( $source, $target ) {
    my ( $start, $end ) = (
        ( first { $source->[$_] != $target->[$_] } keys $source->@* ),
        ( first { $source->[$_] != $target->[$_] } reverse keys $source->@* ),
    );
    return defined $start
        ? all { $source->[ $start + $_ ] == $target->[ $end - $_ ] }
            0 .. ( $end - $start )
        : $source->@* > 0;
}

use Test2::V0 qw( -no_srand );

is reverse_equals( [3, 2, 1, 4], [1 .. 4] ),T,
    'Example 1: reverse_equals( [3, 2, 1, 4], [1 .. 4] ) is true';
is reverse_equals( [1, 3, 4], [4, 1, 3] ), F,
    'Example 2: reverse_equals( [1, 3, 4], [4, 1, 3] ) is false';
is reverse_equals( [2], [2] ), T,
    'Example 3: reverse_equals( [2], [2] ) is true';
is reverse_equals( [], [] ), F,
    'Test 1: reverse_equals( [], [] ) is false';
is reverse_equals( [], [] ), F,
    'Test 2: reverse_equals( [2], [] ) is false';
is reverse_equals( [], [] ), F,
    'Test 3: reverse_equals( [], [3] ) is false';

done_testing;
