#!/usr/bin/env perl

# The Weekly Challenge 270 - By Nelo Tovar
#
# https://theweeklychallenge.org/blog/perl-weekly-challenge-270/
#
# Task 1 - Special Positions
#

use strict;
use warnings;
use v5.28;
use List::MoreUtils qw(one_u);
use Data::Dump qw(dump);

my @examples = (
    [ [1, 0, 0],
      [0, 0, 1],
      [1, 0, 0], ],
    [ [1, 0, 0],
      [0, 1, 0],
      [0, 0, 1], ],
);

sub special_positions {
    my $matrix = shift;
    my $len_rows = scalar @$matrix;
    my $len_cols = scalar @{$matrix->[0]};
    my $count = 0;

    for (my $i = 0; $i < $len_rows; $i++) {
        my @list_row = @{$matrix->[$i]};
        next unless one_u { $_ == 1 } @list_row;

        my @list_col;
        for (my $j = 0; $j < $len_cols; $j++) {
            push @list_col, @{$matrix->[$j]}[$i];
        }
        next unless one_u { $_ == 1 } @list_col;

        $count++;

    }

    return $count;
}

for my $elements (@examples) {
    my $sp = special_positions $elements;

    say 'Input : @matrix = ', dump(@$elements);
    say 'Output : ', $sp;
    say ' ';
}
