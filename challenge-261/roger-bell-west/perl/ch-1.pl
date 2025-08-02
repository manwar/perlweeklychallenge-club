#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(elementdigitsum([1, 2, 3, 45]), 36, 'example 1');
is(elementdigitsum([1, 12, 3]), 9, 'example 2');
is(elementdigitsum([1, 2, 3, 4]), 0, 'example 3');
is(elementdigitsum([236, 416, 336, 350]), 1296, 'example 4');

sub elementdigitsum($a) {
  my $delta = 0;
  foreach my $n0 (@{$a}) {
    my $n= int($n0 / 10);
    my $m = 10;
    while ($n > 0) {
      $delta += ($n % 10) * ($m - 1);
      $n = int($n / 10);
      $m *= 10;
    }
  }
  return $delta;
}
