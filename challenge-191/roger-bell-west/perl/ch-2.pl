#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(cutelist(2), 2, 'example 1');
is(cutelist(10), 700, 'example 2');
is(cutelist(15), 24679, 'example 3');

sub cutelist($n) {
  my @tab = ([]);
  foreach (1..$n) {
    push @tab,[(0) x ($n+1)];
  }
  foreach my $x (1..$n) {
    foreach my $y (1..$x) {
      if ($x % $y != 0 && $y % $x != 0) {
        $tab[$x][$y] = $tab[$y][$x] = 1;
      }
    }
  }
  my $count = 0;
  my @stackl = ([]);
  my @stackc = ([1..$n]);
  while (@stackl) {
    my $l = pop @stackl;
    my $c = pop @stackc;
    if (scalar @{$c} == 0 && scalar @{$l} == $n) {
      $count++;
    } else {
      my $place = scalar @{$l} + 1;
      foreach my $candidate (@{$c}) {
        unless ($tab[$place][$candidate]) {
          push @stackl,[@{$l},$candidate];
          push @stackc,[grep {$_ != $candidate} @{$c}];
        }
      }
    }
  }
  return $count;
}
