#!/usr/bin/env perl

use 5.030;
use warnings;

sub sum_path {
    my ($sum, $tree) = @_;

    my ($number, $left, $right) = @$tree;

    $sum += $number;

    if (defined $left && defined $right) {
        return sum_path($sum, $left) + sum_path($sum, $right);
    } elsif (defined $left) {
        return sum_path($sum, $left);
    } elsif (defined $right) {
        return sum_path($sum, $right);
    } else {
        return $sum;
    }
}

say sum_path(0, [1, [2, [3], [4]]]);
say sum_path(0, [1, [2, [4]], [3, [5], [6]]]);
