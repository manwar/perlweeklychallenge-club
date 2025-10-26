#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(arrayformcompute([1, 2, 3, 4], 12), [1, 2, 4, 6], 'example 1');
is_deeply(arrayformcompute([2, 7, 4], 181), [4, 5, 5], 'example 2');
is_deeply(arrayformcompute([9, 9, 9], 1), [1, 0, 0, 0], 'example 3');
is_deeply(arrayformcompute([1, 0, 0, 0, 0], 9999), [1, 9, 9, 9, 9], 'example 4');
is_deeply(arrayformcompute([0], 1000), [1, 0, 0, 0], 'example 5');

sub u2a($a) {
  my $p = $a;
  if ($p > 0) {
    my @out;
    while ($p > 0) {
      unshift @out, $p % 10;
      $p = int($p / 10);
    }
    \@out;
  } else {
    [0];
  }
}

sub a2u($a) {
  my $acc = 0;
  foreach my $d (@{$a}) {
    $acc *= 10;
    $acc += $d;
  }
  $acc
}

sub arrayformcompute($a, $b) {
  u2a(a2u($a) + $b);
}
