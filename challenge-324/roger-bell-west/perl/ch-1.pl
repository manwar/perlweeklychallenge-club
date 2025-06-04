#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(twodarray([1, 2, 3, 4], 2, 2), [[1, 2], [3, 4]], 'example 1');
is_deeply(twodarray([1, 2, 3], 1, 3), [[1, 2, 3]], 'example 2');
is_deeply(twodarray([1, 2, 3, 4], 4, 1), [[1], [2], [3], [4]], 'example 3');

sub twodarray($i, $r, $c) {
  my @out;
  while (my ($ct, $n) = each @{$i}) {
    if ($ct % $c == 0) {
      push @out, [];
    }
    push @{$out[-1]}, $n;
  }
  \@out
}
