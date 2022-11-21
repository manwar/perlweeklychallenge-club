#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;
use List::Util qw(sum min);

is(equaldistribution([1, 0, 5]), 4, 'example 1');
is(equaldistribution([0, 2, 0]), -1, 'example 2');
is(equaldistribution([0, 3, 0]), 2, 'example 3');

sub equaldistribution($list) {
  my $s = sum(@{$list});
  if ($s % (scalar @{$list}) != 0) {
    return -1;
  }
  my $m = $s / scalar @{$list};
  my $out = 0;
  my @w = @{$list};
  while (1) {
    foreach my $i (0..$#w-1) {
      if ($w[$i] > $m) {
        my $v = $w[$i] - $m;
        $w[$i+1] += $v;
        $out += $v;
        $w[$i] = $m;
      } elsif ($w[$i] < $m) {
        my $v = min($m - $w[$i], $w[$i+1]);
        $w[$i+1] -= $v;
        $out += $v;
        $w[$i] += $v;
      }
    }
    my $done = 1;
    foreach my $v (@w) {
      if ($v != $m) {
        $done = 0;
        last;
      }
    }
    if ($done) {
      last;
    }
  }
  return $out;
}
