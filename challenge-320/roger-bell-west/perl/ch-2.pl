#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(sumdifference([1, 23, 4, 5]), 18, 'example 1');
is(sumdifference([1, 2, 3, 4, 5]), 0, 'example 2');
is(sumdifference([1, 2, 34]), 27, 'example 3');

sub sumdifference($a) {
  my $delta = 0;
  foreach my $x (@{$a}) {
    if ($x >= 10) {
      my $digitsum = 0;
      my $xa = $x;
      while ($xa > 0) {
        $digitsum += $xa % 10;
        $xa = int($xa / 10);
      }
      $delta += $x - $digitsum;
    }
  }
  $delta;
}
