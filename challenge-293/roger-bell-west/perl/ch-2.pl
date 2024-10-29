#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 6;

is(boomerang([[1, 1], [2, 3], [3, 2]]), 1, 'example 1');
is(boomerang([[1, 1], [2, 2], [3, 3]]), 0, 'example 2');
is(boomerang([[1, 1], [1, 2], [2, 3]]), 1, 'example 3');
is(boomerang([[1, 1], [1, 2], [1, 3]]), 0, 'example 4');
is(boomerang([[1, 1], [2, 1], [3, 1]]), 0, 'example 5');
is(boomerang([[0, 0], [2, 3], [4, 5]]), 1, 'example 6');

sub boomerang($a) {
  my @delta;
  # coincident points
  foreach my $ij (0, 1) {
    foreach my $ik ($ij + 1 .. 2) {
      if ($a->[$ij][0] == $a->[$ik][0] && $a->[$ij][1] == $a->[$ik][1]) {
        return 0;
      }
    }
    push @delta, [$a->[$ij + 1][0] - $a->[0][0], $a->[$ij + 1][1] - $a->[0][1]];
  }
  # all on the same vertical line
  if ($delta[0][0] == 0 && $delta[1][0] == 0) {
    return 0;
  }
  # just one vertical line
  if ($delta[0][0] == 0 || $delta[1][0] == 0) {
    return 1;
  }
  my $m = $delta[0][1] / $delta[0][0];
  my $c = $a->[0][1] - $a->[0][0] * $m;
  ($a->[2][1] == $a->[2][0] * $m + $c)?0:1;
}
