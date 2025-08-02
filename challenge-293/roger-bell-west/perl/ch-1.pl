#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(similardominoes([[1, 3], [3, 1], [2, 4], [6, 8]]), 2, 'example 1');
is(similardominoes([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]), 3, 'example 2');

sub dvalue($a) {
  if ($a->[0] < $a->[1]) {
    return $a->[0] * 64 + $a->[1];
  } else {
    return $a->[0] + $a->[1] * 64
  }
}

sub similardominoes($a) {
  my %c;
  map {$c{dvalue($_)}++} @{$a};
  my $t = 0;
  foreach my $v (values %c) {
    if ($v > 1) {
      $t += $v;
    }
  }
  return $t;
}
