#!/usr/bin/env raku

#
# Perl Weekly Challenge - 068
#
# Task #1: Zero Matrix
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/
#

use v6.d;

sub MAIN(Int :$R? is copy where { $R >= 2 } = 3,
         Int :$C? is copy where { $C >= 2 } = 3) {

    my $matrix      = get-matrix(--$R, --$C);
    my $zero_matrix = make-zero-matrix($matrix);

    display-matrix('Matrix:', $matrix);
    display-matrix('Zero Matrix:', $zero_matrix);
}

#
#
# METHODS

sub get-matrix(Int $rows where { $rows >= 1 },
               Int $cols where { $cols >= 1 }) {

    # prabability of picking 1 is higher than 0 (80:20).
    my $min   = 0;
    my $max   = 9;
    my $array = [ 1, 0, 1, 1, 1, 1, 1, 0, 1, 1 ];

    my $matrix  = [];
    for 0..$rows -> $r {
        for 0..$cols -> $c {
            $matrix.[$r][$c] = $array.pick;
        }
    }

    return $matrix;
}

sub make-zero-matrix($matrix) {

    my $rows = $matrix.elems - 1;
    my $cols = $matrix.[0].elems - 1;

    my $zero_matrix = [];
    for 0..$rows -> $r {
        for 0..$cols -> $c {
            if $matrix.[$r][$c] == 0 {
                # make zero row
                (0..$cols).map({ $zero_matrix.[$r][$_] = 0 });
                # make zero col
                (0..$rows).map({ $zero_matrix.[$_][$c] = 0 });
            }
        }
    }

    # fill empty cells, if any.
    for 0..$rows -> $r {
        for 0..$cols -> $c {
            $zero_matrix.[$r][$c] = 1 unless
                defined $zero_matrix.[$r][$c];
        }
    }

    return $zero_matrix;
}

sub display-matrix($label, $matrix) {

    say $label;
    for 0..$matrix.elems - 1 -> $r {
        say sprintf("[ %s ]", $matrix.[$r].join(', '));
    }
}
