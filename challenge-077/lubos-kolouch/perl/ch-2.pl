#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Lonely X
# Given an m x n matrix consisting of 'O' and 'X' only, count the total number of
# 'X' surrounded by 'O' only (horizontally, vertically, and diagonally).

sub is_cell_lonely ( $matrix, $r, $c ) {
    my $rows = scalar @$matrix;
    my $cols = scalar @{ $matrix->[0] };

    for my $dr ( -1, 0, 1 ) {
        for my $dc ( -1, 0, 1 ) {
            next if $dr == 0 && $dc == 0;

            my $nr = $r + $dr;
            my $nc = $c + $dc;

            next if $nr < 0 || $nr >= $rows || $nc < 0 || $nc >= $cols;

            return 0 if $matrix->[$nr][$nc] eq 'X';
        }
    }

    return 1;
}

sub count_lonely_x ($matrix) {
    return 0 if !@$matrix || !@{ $matrix->[0] };

    my $rows  = scalar @$matrix;
    my $cols  = scalar @{ $matrix->[0] };
    my $count = 0;

    for my $r ( 0 .. $rows - 1 ) {
        for my $c ( 0 .. $cols - 1 ) {
            next if $matrix->[$r][$c] ne 'X';
            $count++ if is_cell_lonely( $matrix, $r, $c );
        }
    }

    return $count;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    my $matrix1 = [
        [ 'O', 'O', 'X' ],
        [ 'X', 'O', 'O' ],
        [ 'X', 'O', 'O' ],
    ];
    is( count_lonely_x($matrix1), 1, 'Example 1: 1 lonely X' );

    my $matrix2 = [
        [ 'O', 'O', 'X', 'O' ],
        [ 'X', 'O', 'O', 'O' ],
        [ 'X', 'O', 'O', 'X' ],
        [ 'O', 'X', 'O', 'O' ],
    ];
    is( count_lonely_x($matrix2), 2, 'Example 2: 2 lonely X' );

    my $matrix3 = [
        [ 'X', 'X' ],
        [ 'X', 'X' ],
    ];
    is( count_lonely_x($matrix3), 0, 'No lonely X' );

    done_testing();
}
else {
    say "Run via embedded tests.";
}
