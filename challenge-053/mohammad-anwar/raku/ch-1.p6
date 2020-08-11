#!/usr/bin/env perl6

use v6.c;

sub MAIN(Int $rotate-by = 90) {
    die "ERROR: Invalid rotation degree $rotate-by."
        unless $rotate-by ~~ any (90, 180, 270);

    my $matrix = [ [ 1, 2, 3 ], [ 4, 5, 6 ], [ 7, 8, 9 ] ];

    for 1 .. $rotate-by/90 {
        my $rows = $matrix.elems;
        my $cols = $matrix.[0].elems;

        my $_matrix;
        for 0 .. $rows-1 -> $i {
            my $k = 2;
            for 0 .. $cols-1 -> $j {
                $_matrix.[$i][$j] = $matrix.[$k][$i];
                $k--;
            }
        }
        $matrix = $_matrix;
    }

    dd $matrix;
}
