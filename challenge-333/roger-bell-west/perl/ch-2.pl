#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is_deeply(duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]), [1, 0, 0, 2, 3, 0, 0, 4], 'example 1');
is_deeply(duplicatezeros([1, 2, 3]), [1, 2, 3], 'example 2');
is_deeply(duplicatezeros([1, 2, 3, 0]), [1, 2, 3, 0], 'example 3');
is_deeply(duplicatezeros([0, 0, 1, 2]), [0, 0, 0, 0], 'example 4');
is_deeply(duplicatezeros([1, 2, 0, 3, 4]), [1, 2, 0, 0, 3], 'example 5');

sub duplicatezeros($a) {
  my @b;
  foreach my $n (@{$a}) {
    push @b, $n;
    if ($#{$a} ==$#b) {
      last;
    }
    if ($n == 0) {
      push @b, 0;
      if ($#{$a} ==$#b) {
        last;
      }
    }
  }
  \@b;
}
