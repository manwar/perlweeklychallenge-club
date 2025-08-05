#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub duplicate_zeros(@ints) {
    (map $_ || (0, 0), @ints)[0 .. $#ints]
}

use Test2::V0;
plan(5);

is [duplicate_zeros(1, 0, 2, 3, 0, 4, 5, 0)], [1, 0, 0, 2, 3, 0, 0, 4],
    'Example 1';
is [duplicate_zeros(1, 2, 3)], [1, 2, 3], 'Example 2';
is [duplicate_zeros(1, 2, 3, 0)], [1, 2, 3, 0], 'Example 3';
is [duplicate_zeros(0, 0, 1, 2)], [0, 0, 0, 0], 'Example 4';
is [duplicate_zeros(1, 2, 0, 3, 4)], [1, 2, 0, 0, 3], 'Example 5';
