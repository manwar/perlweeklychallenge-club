#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(contiguousarray([1, 0]), 2, 'example 1');
is(contiguousarray([0, 1, 0]), 2, 'example 2');
is(contiguousarray([0, 0, 0, 0, 0]), 0, 'example 3');
is(contiguousarray([0, 1, 0, 0, 1, 0]), 4, 'example 4');

use List::Util qw(sum);

sub contiguousarray($a) {
  my $lm = int((1 + scalar @{$a}) / 2) * 2;
  for (my $l = $lm; $l >= 2; $l -= 2) {
    foreach my $start (0 .. scalar @{$a} - $l) {
      my $end = $start + $l - 1;
      if (sum($a->@[$start .. $end]) * 2 == $l) {
        return $l;
      }
    }
  }
  0;
}
