#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub min_abs_diff(@ints) {
    my @min = (abs($ints[0] - $ints[1]));
    for my $i_idx (0 .. $#ints - 1) {
        my $i = $ints[$i_idx];
        for my $j_idx ($i_idx + 1 .. $#ints) {
            my $j = $ints[$j_idx];
            my $diff = abs($i - $j);
            next if $diff > $min[0];

            @min = ($diff) if $diff < $min[0];
            push @min, [sort { $a <=> $b } $i, $j];
        }
    }
    return @min[1 .. $#min]
}

use Test2::V0;
plan(5);

is [min_abs_diff(4, 2, 1, 3)],
    bag { item $_ for [1, 2], [2, 3], [3, 4]; end() },
    'Example 1';

is [min_abs_diff (10, 100, 20, 30)],
    bag { item $_ for [10, 20], [20, 30]; end() },
    'Example 2';

is [min_abs_diff (-5, -2, 0, 3)],
    bag { item $_ for [-2, 0]; end() },
    'Example 3';

is [min_abs_diff (8, 1, 15, 3)],
    bag { item $_ for [1, 3]; end() },
    'Example 4';

is [min_abs_diff (12, 5, 9, 1, 15)],
    bag { item $_ for [9, 12], [12, 15]; end() },
    'Example 5';
