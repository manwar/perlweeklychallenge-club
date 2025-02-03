#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub check_order(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    return [grep $ints[$_] != $sorted[$_], 0 .. $#ints]
}

use Test2::V0;
plan(3);

is check_order(5, 2, 4, 3, 1), bag { item $_ for 0, 2, 3, 4; end }, 'Example 1';
is check_order(1, 2, 1, 1, 3), bag { item $_ for 1, 3; end }, 'Example 2';
is check_order(3, 1, 3, 2, 3), bag { item $_ for 0, 1, 3; end }, 'Example 3';
