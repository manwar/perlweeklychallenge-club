#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(stepbystep([-3, 2, -3, 4, 2]), 5, 'example 1');
is(stepbystep([1, 2]), 1, 'example 2');
is(stepbystep([1, -2, -3]), 5, 'example 3');

sub stepbystep($a) {
  my $mv = 0;
  my $tot = 0;
  foreach my $s (@{$a}) {
    $tot += $s;
    if ($mv > $tot) {
      $mv = $tot;
    }
  }
  1 - $mv;
}
