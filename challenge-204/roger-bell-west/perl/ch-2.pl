#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(reshapematrix([[1, 2], [3, 4]], 1, 4), [[1, 2, 3, 4]], 'example 1');
is_deeply(reshapematrix([[1, 2, 3], [4, 5, 6]], 3, 2), [[1, 2], [3, 4], [5, 6]], 'example 2');
is_deeply(reshapematrix([[1, 2]], 3, 2), [[0]], 'example 3');

sub reshapematrix($m, $r, $c) {
  my @mv;
  foreach my $rv (@{$m}) {
    push @mv,@{$rv};
  }
  if ($r * $c != scalar @mv) {
    return [[0]];
  }
  my @out;
  foreach my $i (0 .. $r-1) {
    push @out, [@mv[$i * $c .. ($i + 1) * $c - 1]];
  }
  return \@out;
}
