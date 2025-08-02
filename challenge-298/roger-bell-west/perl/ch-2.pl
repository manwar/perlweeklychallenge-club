#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is_deeply(rightinterval([[3, 4], [2, 3], [1, 2]]), [-1, 0, 1], 'example 1');
is_deeply(rightinterval([[1, 4], [2, 3], [3, 4]]), [-1, 2, -1], 'example 2');
is_deeply(rightinterval([[1, 2]]), [-1], 'example 3');
is_deeply(rightinterval([[1, 4], [2, 2], [3, 4]]), [-1, 1, -1], 'example 4');

sub rightinterval($a) {
  my @ss = map {$_->[0]} @{$a};
  my @si = sort {$ss[$::a] <=> $ss[$::b]} (0 .. $#{$a});
  my @out;
  foreach my $l (@{$a}) {
    my @ix = grep {$ss[$_] >= $l->[1]} @si;
    if (@ix) {
      push @out, $ix[0];
    } else {
      push @out, -1;
    }
  }
  \@out;
}
