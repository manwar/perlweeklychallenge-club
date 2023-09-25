#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is_deeply(duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]), [1, 0, 0, 2, 3, 0, 0, 4], 'example 1');
is_deeply(duplicatezeros([1, 2, 3]), [1, 2, 3], 'example 2');
is_deeply(duplicatezeros([0, 3, 0, 4, 5]), [0, 0, 3, 0, 0], 'example 3');

sub duplicatezeros($a) {
  my @out;
  foreach my $t (@{$a}) {
    push @out, $t;
    if ($t == 0) {
      push @out, $t;
    }
    if ($#out >= $#{$a}) {
      last;
    }
  }
  if ($#out > $#{$a}) {
    splice @out, scalar @{$a};
  }
  return \@out;
}
