#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 298 Task 1: Maximal Square
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( all max );

sub maximal_square( $matrix ) {
    my ( $last_r, $last_c ) = ( $matrix->$#*, $matrix->[0]->$#* );
    my $max = 0;
    for my $r ( 0..$last_r ) {
        for my $c ( 0..$last_c ) {
            next
                if $matrix->[$r][$c] != 1;
            my $w = 1;
            while ( $r + $w <= $last_r
                && $c + $w <= $last_c
                && ( all { $matrix->[ $r + $_ ][ $c + $w ] } 0 .. $w )
                && ( all { $matrix->[ $r + $w ][ $c + $_ ] } 0 .. $w - 1 ) )
            {
                ++$w;
            }
            $max = $w
                if $w > $max;
        }
    }
    return $max * $max;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is maximal_square( [
  [1, 0, 1, 0, 0],
  [1, 0, 1, 1, 1],
  [1, 1, 1, 1, 1],
  [1, 0, 0, 1, 0],
] ), 4,
    'Example 1: maximal_square( [
  [1, 0, 1, 0, 0],
  [1, 0, 1, 1, 1],
  [1, 1, 1, 1, 1],
  [1, 0, 0, 1, 0],
] ) == 4';
is maximal_square( [[0, 1], [1, 0]] ), 1,
    'Example 2: maximal_square( [[0, 1], [1, 0]] ) == 1';
is maximal_square( [[0]] ), 0,
    'Example 3: maximal_square( [[0]] ) == 0';

done_testing;
