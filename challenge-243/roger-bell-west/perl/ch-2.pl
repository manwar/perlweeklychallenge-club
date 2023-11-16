#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(floorsum([2, 5, 9]), 10, 'example 1');
is(floorsum([7, 7, 7, 7, 7, 7, 7]), 49, 'example 2');

sub floorsum($a) {
  use integer;
  my $n = 0;
  foreach my $iv (@{$a}) {
    foreach my $jv (@{$a}) {
      $n += $iv / $jv;
    }
  }
  return $n;
}
