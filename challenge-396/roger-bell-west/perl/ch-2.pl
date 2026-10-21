#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(trionicarray([1, 3, 5, 4, 2, 6, 8]), 1, 'example 1');
is(trionicarray([1, 4, 4, 2, 1, 3, 5]), 0, 'example 2');
is(trionicarray([2, 10, 3, 1, 9]), 1, 'example 3');
is(trionicarray([1, 2, 3, 4, 3, 2, 1]), 0, 'example 4');
is(trionicarray([1, 3, 2, 4, 1, 5, 2]), 0, 'example 5');

sub trionicarray($a) {
  my $state = 0;
  my $prev = $a->[0];
  foreach my $n (@{$a}[1..$#{$a}]) {
    my $dir = 0;
    if ($n > $prev) {
      $dir = 1;
    } elsif ($n < $prev) {
      $dir = -1;
    }
    if ($dir == 0) {
      return 0;
    }
    if ($state == 0) {
      if ($dir == 1) {
        $state = 1;
      } else {
        return 0;
      }
    } elsif ($state == 1) {
      if ($dir == -1) {
        $state = 2;
      }
    } elsif ($state == 2) {
      if ($dir == 1) {
        $state = 3;
      }
    } elsif ($state == 3) {
      if ($dir == -1) {
        return 0;
      }
    } else {
      return 0;
    }
    $prev = $n;
  }
  ($state == 3)?1:0;
}
