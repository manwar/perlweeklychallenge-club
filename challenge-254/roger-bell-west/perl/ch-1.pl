#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(threepower(27), 1, 'example 1');
is(threepower(0), 0, 'example 2');
is(threepower(6), 0, 'example 3');

sub threepower($n0) {
  if ($n0 == 0) {
    return 0;
  }
  my $n = abs($n0);
  my $lo = 1;
  my $hi = int($n / 2);
  while (1) {
    my $t = int(($lo + $hi) / 2);
    my $c = $t * $t * $t;
    if ($c == $n) {
      return 1;
    }
    if ($lo == $t) {
      return 0;
    }
    if ($c < $n) {
      $lo = $t;
    } else {
      $hi = $t;
    }
  }
}
