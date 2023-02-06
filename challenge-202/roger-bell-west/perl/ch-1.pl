#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(consecutiveodds([1, 5, 3, 6]), 1, 'example 1');
is(consecutiveodds([2, 6, 3, 5]), 0, 'example 2');
is(consecutiveodds([1, 2, 3, 4]), 0, 'example 3');
is(consecutiveodds([2, 3, 5, 7]), 1, 'example 4');

sub consecutiveodds($a) {
  my $i = 0;
  foreach my $v (@{$a}) {
    if ($v % 2 == 1) {
      $i++;
      if ($i >= 3) {
        return 1;
      }
    } else {
      $i = 0;
    }
  }
  return 0;
}
