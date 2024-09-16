#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub order_game(@ints) {
    return $ints[0] if 1 == @ints;

    my @mins;
    while (my ($x, $y) = splice @ints, 0, 2) {
        push @mins, ($x, $y)[($y <=> $x) == @mins % 2 * 2 - 1];
    }
    return order_game(@mins)
}

use Test::More tests => 3 + 2;

is order_game(2, 1, 4, 5, 6, 3, 0, 2), 1, 'Example 1';
is order_game(0, 5, 3, 2), 0, 'Example 2';
is order_game(9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8), 2, 'Example 3';

is order_game(42), 42, 'Single number';
is order_game(3, 7), 3, 'Single tuple';
