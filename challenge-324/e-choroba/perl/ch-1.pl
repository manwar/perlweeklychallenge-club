#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use PDL;

sub array_2d($r, $c, @ints) {
    pdl(@ints)->reshape($c, $r)->unpdl
}

use Test2::V0 qw{ is plan };
plan(3 + 2);

is array_2d(2, 2, 1, 2, 3, 4), [[1, 2], [3, 4]], 'Example 1';
is array_2d(1, 3, 1, 2, 3), [[1, 2, 3]], 'Example 2';
is array_2d(4, 1, 1, 2, 3, 4), [[1], [2], [3], [4]], 'Example 3';

is array_2d(2, 3, 1, 2), [[1, 2, 0], [0, 0, 0]], 'Not enough data';
is array_2d(1, 2, 1, 2, 3), [[1, 2]], 'Too much data';
