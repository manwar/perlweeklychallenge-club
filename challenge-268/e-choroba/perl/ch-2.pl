#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub number_game(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    return [map { @sorted[$_ * 2 + 1, $_ * 2] } 0 .. $#sorted / 2]
}

use Test2::V0;
plan(3);

is number_game(2, 5, 3, 4), [3, 2, 5, 4], 'Example 1';
is number_game(9, 4, 1, 3, 6, 4, 6, 1), [1, 1, 4, 3, 6, 4, 9, 6], 'Example 2';
is number_game(1, 2, 2, 3), [2, 1, 3, 2], 'Example 3';
