#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(flipmatrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]]), [[1, 0, 0], [0, 1, 0], [1, 1, 1]], 'example 1');
is_deeply(flipmatrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]), [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], 'example 2');

sub flipmatrix($a) {
  return [map {[reverse map {1 - $_} @{$_}]} @{$a}];
}
