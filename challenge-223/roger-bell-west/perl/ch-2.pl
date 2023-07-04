#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(boxcoins([3, 1, 5, 8]), 167, 'example 1');
is(boxcoins([1, 5]), 10, 'example 2');

sub boxcoins($ints) {
  my $mx = 0;
  my @stack = ([$ints, 0]);
  while (scalar @stack > 0) {
    my $x = pop @stack;
    my $t = $x->[0];
    my $tot = $x->[1];
    if ($tot > $mx) {
      $mx = $tot;
    }
    foreach my $i (0..$#{$t}) {
      my $p = $t->[$i];
      if ($i > 0) {
        $p *= $t->[$i - 1];
      }
      if ($i < $#{$t}) {
        $p *= $t->[$i + 1];
      }
      my $stot = $tot + $p;
      my @tt;
      foreach my $ix (0..$#{$t}) {
        if ($i != $ix) {
          push @tt, $t->[$ix];
        }
      }
      push @stack, [\@tt, $stot];
    }
  }
  return $mx;
}
