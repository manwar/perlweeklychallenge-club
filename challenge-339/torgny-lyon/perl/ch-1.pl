#!/usr/bin/perl

use v5.42;

use Test::More tests => 5;

sub find_max_diff {
    my @ints = sort { $b <=> $a } map { abs } @_;
    $ints[0] * $ints[1] - $ints[$#ints] * $ints[$#ints - 1];
}

is(find_max_diff(5, 9, 3, 4, 6),   42);
is(find_max_diff(1, -2, 3, -4),    10);
is(find_max_diff(-3, -1, -2, -4),  10);
is(find_max_diff(10, 2, 0, 5, 1),  50);
is(find_max_diff(7, 8, 9, 10, 10), 44);
