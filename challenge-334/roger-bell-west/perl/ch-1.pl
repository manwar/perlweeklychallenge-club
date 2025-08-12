#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(rangesum([-2, 0, 3, -5, 2, -1], 0, 2), 1, 'example 1');
is(rangesum([1, -2, 3, -4, 5], 1, 3), -3, 'example 2');
is(rangesum([1, 0, 2, -1, 3], 3, 4), 2, 'example 3');
is(rangesum([-5, 4, -3, 2, -1, 0], 0, 3), -2, 'example 4');
is(rangesum([-1, 0, 2, -3, -2, 1], 0, 2), 1, 'example 5');

use List::Util qw(sum);

sub rangesum($a, $s, $e) {
  sum(@$a[$s .. $e]);
}
