#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(reversepairs([1, 3, 2, 3, 1]), 2, 'example 1');
is(reversepairs([2, 4, 3, 5, 1]), 3, 'example 2');

use Algorithm::Combinatorics qw(combinations);

sub reversepairs($a) {
  return scalar grep {$_->[0] > 2 * $_->[1]} combinations($a, 2);
}
