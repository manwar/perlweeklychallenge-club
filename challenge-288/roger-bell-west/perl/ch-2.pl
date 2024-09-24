#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(contiguousblock([['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'o', 'o']]), 11, 'example 1');
is(contiguousblock([['x', 'x', 'x', 'x', 'x'], ['x', 'o', 'o', 'o', 'o'], ['x', 'x', 'x', 'x', 'o'], ['x', 'o', 'o', 'o', 'o']]), 11, 'example 2');
is(contiguousblock([['x', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x'], ['o', 'x', 'x', 'o', 'o'], ['o', 'o', 'o', 'x', 'x']]), 7, 'example 3');

sub encode($x, $y) {
  return $x * 1e6 + $y;
}

sub decode($c) {
  return [int($c / 1e6), $c % 1e6];
}

sub contiguousblock($a) {
  my $y = scalar @{$a};
  my $x = scalar @{$a->[0]};
  my %starts;
  foreach my $cx (0 .. $x - 1) {
    foreach my $cy (0 .. $y - 1) {
      $starts{encode($cx, $cy)} = 1;
    }
  }
  my $maxblock = 0;
  while (scalar keys %starts > 0) {
    my $start = (keys %starts)[0];
    my $cstart = decode($start);
    my @queue;
    my %visited;
    $visited{$start} = 1;
    push @queue, $start;
    while (scalar @queue > 0) {
      my $here = shift @queue;
      my $chere = decode($here);
      foreach my $delta ([-1, 0], [1, 0], [0, -1], [0, 1]) {
        if (($delta->[0] >= 0 || $chere->[0] > 0)
            && ($delta->[0] <= 0 || $chere->[0] < $x - 1)
            && ($delta->[1] >= 0 || $chere->[1] > 0)
            && ($delta->[1] <= 0 || $chere->[1] < $y - 1)) {
          my $cthere = [$chere->[0] + $delta->[0], $chere->[1] + $delta->[1]];
          my $there = encode(@{$cthere});
          if (!exists $visited{$there} &&
              $a->[$cthere->[1]][$cthere->[0]]
              eq $a->[$cstart->[1]][$cstart->[0]]) {
            $visited{$there} = 1;
            push @queue, $there;
          }
        }
      }
    }
    my $size = scalar keys %visited;
    if ($size > $maxblock) {
      $maxblock = $size;
    }
    foreach my $k (keys %visited) {
      delete $starts{$k};
    }
  }
  return $maxblock;
}
