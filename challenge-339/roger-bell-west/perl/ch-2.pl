#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(peakpoint([-5, 1, 5, -9, 2]), 1, 'example 1');
is(peakpoint([10, 10, 10, -25]), 30, 'example 2');
is(peakpoint([3, -4, 2, 5, -6, 1]), 6, 'example 3');
is(peakpoint([-1, -2, -3, -4]), 0, 'example 4');
is(peakpoint([-10, 15, 5]), 10, 'example 5');

use List::Util qw(max);

sub peakpoint($a) {
  my $h = 0;
  my $o = 0;
  foreach my $p (@{$a}) {
    $h += $p;
    $o = max($o, $h);
  }
  $o;
}
