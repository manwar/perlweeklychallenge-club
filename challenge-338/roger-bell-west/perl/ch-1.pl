#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(highestrow([[4, 4, 4, 4], [10, 0, 0, 0], [2, 2, 2, 9]]), 16, 'example 1');
is(highestrow([[1, 5], [7, 3], [3, 5]]), 10, 'example 2');
is(highestrow([[1, 2, 3], [3, 2, 1]]), 6, 'example 3');
is(highestrow([[2, 8, 7], [7, 1, 3], [1, 9, 5]]), 17, 'example 4');
is(highestrow([[10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]]), 100, 'example 5');

use List::Util qw(sum max);

sub highestrow($a) {
  max map {sum @{$_}} @{$a};
}
