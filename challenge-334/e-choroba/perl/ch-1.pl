#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ sum0 };

sub range_sum($ints, $x, $y) {
    no warnings 'uninitialized';
    sum0(@$ints[$x .. $y])
}

use Test::More tests => 5 + 2;

is range_sum([-2, 0, 3, -5, 2, -1], 0, 2), 1, 'Example 1';
is range_sum([1, -2, 3, -4, 5], 1, 3), -3, 'Example 2';
is range_sum([1, 0, 2, -1, 3], 3, 4), 2, 'Example 3';
is range_sum([-5, 4, -3, 2, -1, 0], 0, 3), -2, 'Example 4';
is range_sum([-1, 0, 2, -3, -2, 1], 0, 2), 1, 'Example 5';

is range_sum([1, 2, 3], 1, 0), 0, 'Wrong order';
is range_sum([1, 2, 3], 0, 10), 6, 'Out of bounds';
