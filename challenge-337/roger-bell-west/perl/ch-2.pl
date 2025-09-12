#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(oddmatrix(2, 3, [[0, 1], [1, 1]]), 6, 'example 1');
is(oddmatrix(2, 2, [[1, 1], [0, 0]]), 0, 'example 2');
is(oddmatrix(3, 3, [[0, 0], [1, 2], [2, 1]]), 0, 'example 3');
is(oddmatrix(1, 5, [[0, 2], [0, 4]]), 2, 'example 4');
is(oddmatrix(4, 2, [[1, 0], [3, 1], [2, 0], [0, 1]]), 8, 'example 5');

sub oddmatrix($rows, $cols, $points) {
  my %rm;
  my %cm;
  foreach my $p (@{$points}) {
    if (exists $rm{$p->[0]}) {
      delete $rm{$p->[0]};
    } else {
      $rm{$p->[0]} = 1;
    }
    if (exists $cm{$p->[1]}) {
      delete $cm{$p->[1]};
    } else {
      $cm{$p->[1]} = 1;
    }
  }
  (scalar %rm) * ($cols - (scalar %cm)) +
    (scalar %cm) * ($rows - (scalar %rm));
}
