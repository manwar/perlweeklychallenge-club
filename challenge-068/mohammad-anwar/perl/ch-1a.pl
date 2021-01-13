#!/usr/bin/perl

#
# Perl Weekly Challenge - 068
#
# Task #1: Zero Matrix
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068/
#

use strict;
use warnings;

use Test::More;
use Test::Deep;

is_deeply( make_zero_matrix([[1, 0, 1],[1, 1, 1],[1, 1, 1]]),
           [[0, 0, 0],[1, 0, 1],[1, 0, 1]],
           'testing example 1' );
is_deeply( make_zero_matrix([[1, 0, 1],[1, 1, 1],[1, 0, 1]]),
           [[0, 0, 0],[1, 0, 1],[0, 0, 0]],
           'testing example 2' );

done_testing;

#
#
# METHODS

sub make_zero_matrix {
    my ($matrix) = @_;

    my $rows = $#$matrix;
    my $cols = $#{$matrix->[0]};

    my $zero_matrix = [];
    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            if ($matrix->[$r][$c] == 0) {
                # make zero row
                $zero_matrix->[$r][$_] = 0 foreach (0..$cols);
                # make zero col
                $zero_matrix->[$_][$c] = 0 foreach (0..$rows);
            }
        }
    }

    # fill empty cells, if any.
    foreach my $r (0..$rows) {
        foreach my $c (0..$cols) {
            $zero_matrix->[$r][$c] = 1 unless
                defined $zero_matrix->[$r][$c];
        }
    }

    return $zero_matrix;
}
