#! /usr/bin/perl
use warnings;
use strict;
use experimental 'signatures';

sub arithmetic_slices ($arr) {
    return [] if @$arr < 3;
    my $indicator = 0 x (@$arr - 3) . '111';
    my @slices;
  SLICE:
    while (1) {
        next if 3 > $indicator =~ tr/1//;
        my @slice = @$arr[ map substr($indicator, $_, 1) ? $_ : (),
                               0 .. $#$arr ];
        my $d = $slice[0] - $slice[1];
        $d != $slice[ $_ - 1 ] - $slice[$_] and next SLICE for 2 .. $#slice;

        push @slices, \@slice;

    } continue {
        increment(\$indicator) or last
    }
    return \@slices
}

sub increment($indicator) {
    $$indicator =~ s/0$/1/
    or $$indicator =~ s/0(1+)$/1 . 0 x length $1/e
    or 0
}

use Test2::V0;
plan 2 + 3;

is arithmetic_slices([1, 2, 3, 4]),
    bag { item $_ for [1, 2, 3], [2, 3, 4], [1, 2, 3, 4] },
    'Example 1';

is arithmetic_slices([2]), [], 'Example 2';

is arithmetic_slices([3, 2, 1]),
    [[3, 2, 1]],
    'Decreasing';

is arithmetic_slices([3, 5, 7, 9, 11]),
    bag { item $_ for [3, 7, 11],
                      [3, 5, 7], [5, 7, 9], [7, 9, 11],
                      [3, 5, 7, 9], [5, 7, 9, 11],
                      [3, 5, 7, 9, 11] },
    'Skipping';

is arithmetic_slices([(1) x 4]),
    bag { item $_ for ([1, 1, 1]) x 4, [(1) x 4] },
    'All the same';
