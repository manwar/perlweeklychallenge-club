#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(matrixscore([[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 1, 0]]), 39, 'example 1');
is(matrixscore([[0]]), 1, 'example 2');

sub matrixscore($matrix) {
  foreach my $i (0..$#{$matrix}) {
    if ($matrix->[$i][0] == 0) {
      foreach my $j (0..$#{$matrix->[0]}) {
        $matrix->[$i][$j] = 1 - $matrix->[$i][$j];
      }
    }
  }
  my $t = int(scalar @{$matrix} / 2);
  foreach my $i (1..$#{$matrix->[0]}) {
    my $c = 0;
    foreach my $j (0..$#{$matrix}) {
      if ($matrix->[$j][$i] == 0) {
        $c++;
      }
    }
    if ($c > $t) {
      foreach my $j (0..$#{$matrix}) {
        $matrix->[$j][$i] = 1 - $matrix->[$j][$i];
      }
    }
  }
  my $tot = 0;
  foreach my $m (@{$matrix}) {
    my $p = 0;
    foreach my $n (@{$m}) {
      $p *= 2;
      if ($n == 1) {
        $p++;
      }
    }
    $tot += $p;
  }
  return $tot;
}
