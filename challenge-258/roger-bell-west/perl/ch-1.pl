#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(countevendigitsnumber([10, 1, 111, 24, 1000]), 3, 'example 1');
is(countevendigitsnumber([111, 1, 11111]), 0, 'example 2');
is(countevendigitsnumber([2, 8, 1024, 256]), 1, 'example 3');

sub countevendigitsnumber($a) {
  my $t = 0;
  foreach my $p (@{$a}) {
    my $even = 0;
    my $pt = $p;
    while ($pt >= 10) {
      $pt = int($pt / 10);
      $even = !$even;
    }
    if ($even) {
      $t += 1;
    }
  }
  return $t;
}
