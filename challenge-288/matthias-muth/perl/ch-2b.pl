#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 288 Task 2: Contiguous Block
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( max );
use Algorithm::Loops qw( NestedLoops );

sub flood_and_mark( $matrix, $r, $c, $visited ) {
    $visited->[$r][$c] = 1;
    my @neighbors = (
        $r > 0                  ? ( $r - 1, $c ) : (),
        $c > 0                  ? ( $r, $c - 1 ) : (),
        $c < $matrix->[$r]->$#* ? ( $r, $c + 1 ) : (),
        $r < $matrix->$#*       ? ( $r + 1, $c ) : (),
    );
    my $symbol = $matrix->[$r][$c];
    my $count = 1;      # For this field itself.
    for my ( $next_r, $next_c ) ( @neighbors ) {
        next
            if $matrix->[$next_r][$next_c] ne $symbol
                || $visited->[$next_r][$next_c];
        $count += flood_and_mark( $matrix, $next_r, $next_c, $visited );
    }
    return $count;
}

sub contiguous_block( $matrix ) {
    my @visited;
    my $max = 0;

    my @rows    = ( 0..$matrix->$#* );          # row indices
    my @columns = ( 0..$matrix->[0]->$#* );     # column indices
    my $iterator = NestedLoops( [ \@rows, \@columns ] );
    while ( my ( $r, $c ) = $iterator->() ) {
        if ( ! $visited[$r][$c] ) {
            my $area = flood_and_mark( $matrix, $r, $c, \@visited );
            $max = $area
                if $area > $max;
        }
    }
    return $max;
}

use Test2::V0 qw( -no_srand );
is contiguous_block( [
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "o", "o"],
] ), 11,
    'Example 1: contiguous_block( [
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "o", "o"],
] ) == 11';
is contiguous_block( [
  ["x", "x", "x", "x", "x"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
] ), 11,
    'Example 2: contiguous_block( [
  ["x", "x", "x", "x", "x"],
  ["x", "o", "o", "o", "o"],
  ["x", "x", "x", "x", "o"],
  ["x", "o", "o", "o", "o"],
] ) == 11';
is contiguous_block( [
  ["x", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
  ["o", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
] ), 7,
    'Example 3: contiguous_block( [
  ["x", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
  ["o", "x", "x", "o", "o"],
  ["o", "o", "o", "x", "x"],
] ) == 7';

is contiguous_block( [
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
] ), 1,
    'Extra 1: contiguous_block( [
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
  ["x", "o", "x", "o", "x"],
  ["o", "x", "o", "x", "o"],
] ) == 1';

is contiguous_block( [] ), 0,
    'Extra 2: contiguous_block( [] ) == 0';

done_testing;
