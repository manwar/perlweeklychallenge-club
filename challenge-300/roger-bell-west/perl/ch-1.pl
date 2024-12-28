#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(beautifularrangement(2), 2, 'example 1');
is(beautifularrangement(1), 1, 'example 2');
is(beautifularrangement(10), 700, 'example 3');
is(beautifularrangement(20), 1939684, 'example 4');

sub beautifularrangement($a) {
  my @precalc;
  foreach my $i (0 .. $a) {
    push @precalc, [(0) x ($a + 1)];
  }
  foreach my $i (1 .. $a) {
    for (my $j = $i; $j <= $a; $j += $i) {
      $precalc[$i][$j] = 1;
      $precalc[$j][$i] = 1;
    }
  }
  my $ct = 0;
  my @stack;
  push @stack, [1 .. $a];
  while (scalar @stack > 0) {
    my $trail = pop @stack;
    if (scalar @{$trail} == 1) {
      $ct++;
    } else {
      my $p = $a - (scalar @{$trail}) + 2;
      foreach my $i (@{$trail}) {
        if ($precalc[$i][$p]) {
          my @tt = grep {$_ != $i} @{$trail};
          push @stack, \@tt;
        }
      }
    }
  }
  $ct;
}
