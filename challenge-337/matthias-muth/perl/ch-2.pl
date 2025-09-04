#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 337 Task 2: Odd Matrix
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub odd_matrix_traditional( $row, $col, $locations ) {
    my @row_sums = ( 0 ) x $row;
    my @column_sums = ( 0 ) x $col;
    for ( $locations->@* ) {
        my ( $r, $c ) = $_->@[0,1];
        ++$row_sums[$r];
        ++$column_sums[$c];
    }

    my $odd_count = 0;
    for my $r ( 0 .. $row - 1 ) {
        for my $c ( 0 .. $col - 1 ) {
            $odd_count += ( $row_sums[$r] + $column_sums[$c] ) % 2;
        }
    }
    return $odd_count;
}

use List::MoreUtils qw( frequency );

sub odd_matrix( $row, $col, $locations ) {
    my %row_freq = frequency map $_->[0], $locations->@*;
    my %col_freq = frequency map $_->[1], $locations->@*;
    my $n_odd_rows = scalar grep $_ & 1, values %row_freq;
    my $n_odd_cols = scalar grep $_ & 1, values %col_freq;
    my ( $n_even_rows, $n_even_cols ) =
        ( $row - $n_odd_rows, $col - $n_odd_cols );
    return $n_odd_rows * $n_even_cols + $n_even_rows * $n_odd_cols;
}

use Test2::V0 qw( -no_srand );

is odd_matrix( 2, 3, [[0, 1], [1, 1]] ), 6,
    'Example 1: odd_matrix( 2, 3, [[0, 1], [1, 1]] ) == 6';
is odd_matrix( 2, 2, [[1, 1], [0, 0]] ), 0,
    'Example 2: odd_matrix( 2, 2, [[1, 1], [0, 0]] ) == 0';
is odd_matrix( 3, 3, [[0, 0], [1, 2], [2, 1]] ), 0,
    'Example 3: odd_matrix( 3, 3, [[0, 0], [1, 2], [2, 1]] ) == 0';
is odd_matrix( 1, 5, [[0, 2], [0, 4]] ), 2,
    'Example 4: odd_matrix( 1, 5, [[0, 2], [0, 4]] ) == 2';
is odd_matrix( 4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]] ), 8,
    'Example 5: odd_matrix( 4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]] ) == 8';

done_testing;
