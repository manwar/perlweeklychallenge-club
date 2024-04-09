#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(targetarray([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]), [0, 4, 1, 3, 2], 'example 1');
is_deeply(targetarray([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]), [0, 1, 2, 3, 4], 'example 2');
is_deeply(targetarray([1], [0]), [1], 'example 3');

sub targetarray($a, $indices) {
  my @c;
  while (my ($i, $ix) = each @{$indices}) {
    if ($ix == scalar @c) {
      push @c, $a->[$i];
    } else {
      splice @c, $ix, 0, $a->[$i];
    }
  }
  return \@c;
}
