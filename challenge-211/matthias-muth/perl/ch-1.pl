#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 211 Task 1: Toeplitz Matrix
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use Data::Dump qw( pp );
use List::Util qw( min max any all );

sub is_toeplitz_by_diagonals {
    my ( $matrix ) = @_;

    my ( $m, $n) = ( scalar @$matrix, scalar @{$matrix->[0]} );

    die "all rows must have the same length"
        unless all { @{$matrix->[$_]} == $n } 1..$#$matrix;

    for my $d ( -( $m - 1 ) .. +( $n - 1 ) ) {
        my $i0 = - min( $d, 0 );
        my $j0 = max( 0, $d );
        my $imax = min( $m - 1, $m - $d );
        # say "    i0:$i0 imax:$imax";
        return "false"
            if any {
                my ( $i, $j ) = ( $_, $_+ $d );
                $matrix->[$i][$j] != $matrix->[$i0][$j0]
            } $i0 .. $imax;
    }
    return "true";
}

sub is_toeplitz_by_elements {
    my ( $matrix ) = @_;

    die "all rows must have the same length"
        unless all { $#{$matrix->[$_]} == $#{$matrix->[0]} } 1..$#$matrix;

    # For every row, starting from the second one,
    # check all fields in that row to contain the same value as the element
    # diagonally above and left. Start with the second field, as the first one
    # doesn't have another field to compare with.
    for my $i ( 1..$#$matrix ) {
        return "false"
            if any { $matrix->[$i][$_] != $matrix->[ $i - 1 ][ $_ - 1 ] }
                1..$#{$matrix->[$i]};
    }

    # All elements fulfill that criteria, so the matrix is a Toeplitz matrix.
    return "true";
}


use Test::More;
use Data::Dump qw( pp );

do {
    is is_toeplitz_by_diagonals( $_->{INPUT} ), $_->{EXPECTED},
        "is_toeplitz_by_diagonals(" . pp( $_->{INPUT} ) . " == $_->{EXPECTED}";
    is is_toeplitz_by_elements( $_->{INPUT} ), $_->{EXPECTED},
        "is_toeplitz_by_elements(" . pp( $_->{INPUT} ) . " == $_->{EXPECTED}";
} for (
    { INPUT => [ [ 4,3,2,1 ], [ 5,4,3,2 ], [ 6,5,4,3 ] ], EXPECTED => "true" },
    { INPUT => [ [ 1,2,3 ], [ 3,2,1 ] ], EXPECTED => "false" },
    { INPUT =>  [ [1, 2, 3, 4],
                  [5, 1, 2, 3],
                  [9, 5, 1, 2]
                ], EXPECTED => "true" },
);

done_testing;
