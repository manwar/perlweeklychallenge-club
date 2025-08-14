#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub nearest_valid_point($x, $y, @points) {
    my $nearest;
    for my $i (0 .. $#points) {
        my $point = $points[$i];
        next if $x != $point->[0] && $y != $point->[1];

        my $distance = _distance($x, $y, @$point);
        $nearest = $i if ! defined $nearest
                      || $distance < _distance($x, $y, @{ $points[$nearest] });
    }
    return $nearest // -1
}

sub _distance($x1, $y1, $x2, $y2) {
    abs($x1 - $x2) + abs($y1 - $y2)
}

use Test::More tests => 5;

is nearest_valid_point(3, 4, [1, 2], [3, 1], [2, 4], [2, 3]), 2, 'Example 1';
is nearest_valid_point(2, 5, [3, 4], [2, 3], [1, 5], [2, 5]), 3, 'Example 2';
is nearest_valid_point(1, 1, [2, 2], [3, 3], [4, 4]), -1, 'Example 3';
is nearest_valid_point(0, 0, [0, 1], [1, 0], [0, 2], [2, 0]), 0, 'Example 4';
is nearest_valid_point(5, 5, [5, 6], [6, 5], [5, 4], [4, 5]), 0, 'Example 5';
