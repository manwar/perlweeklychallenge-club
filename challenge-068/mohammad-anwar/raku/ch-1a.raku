#!/usr/bin/env raku

#
# Perl Weekly Challenge - 068
#
# Task #1: Zero Matrix
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/
#

use Test;

is-deeply make-zero-matrix([[1, 0, 1], [1, 1, 1], [1, 1, 1]]),
          [[0, 0, 0], [1, 0, 1], [1, 0, 1]],
          'testing example 1';
is-deeply make-zero-matrix([[1, 0, 1], [1, 1, 1], [1, 0, 1]]),
          [[0, 0, 0], [1, 0, 1], [0, 0, 0]],
          'testing example 2';

done-testing;

#
#
# METHODS

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
