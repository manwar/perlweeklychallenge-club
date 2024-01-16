#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(uniquesumzero(5), [1, 2, 3, 4, -10], 'example 1');
is_deeply(uniquesumzero(3), [1, 2, -3], 'example 2');
is_deeply(uniquesumzero(1), [0], 'example 3');

sub uniquesumzero($n) {
  if ($n == 1) {
    return [0];
  }
  my @p = (1 .. $n - 1);
  push @p, -$n * ($n - 1) / 2;
  return \@p;
}
