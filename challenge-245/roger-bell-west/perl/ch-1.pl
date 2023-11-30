#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(sortlanguage(['perl', 'c', 'python'], [2, 1, 3]), ['c', 'perl', 'python'], 'example 1');
is_deeply(sortlanguage(['c++', 'haskell', 'java'], [1, 3, 2]), ['c++', 'java', 'haskell'], 'example 2');

sub sortlanguage($langs, $popularities) {
  my @ix = sort {$popularities->[$a] <=> $popularities->[$b]} (0 .. $#{$langs});
  return [map {$langs->[$_]} @ix];
}
