#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(knightsmove('g2', 'a8'), 4, 'example 1');
is(knightsmove('g2', 'h2'), 3, 'example 2');

sub cs2xy($a) {
  my @c = split('', $a);
  my $x = ord($c[0]) - ord('a');
  my $y = ord($c[1]) - ord('1');
  return [$x, $y];
}

sub knightsmove($from, $to) {
  my $fc = cs2xy($from);
  my $tc = cs2xy($to);
  my @queue;
  push @queue, [$fc->[0], $fc->[1], 0];
  my %seen;
  while (@queue) {
    my $cc = shift @queue;
    if ($cc->[0] == $tc->[0] && $cc->[1] == $tc->[1]) {
      return $cc->[2];
    } else {
      foreach my $offset (
        [2, 1],
        [1, 2],
        [2, -1],
        [1, -2],
        [-2, 1],
        [-1, 2],
        [-2, -1],
        [-1, -2]
          ) {
        my $x = $cc->[0] + $offset->[0];
        my $y = $cc->[1] + $offset->[1];
        if ($x >= 0 && $x <= 7 && $y >= 0 && $y <= 7) {
          my $cv = $x * 8 + $y;
          if (!exists $seen{$cv}) {
            push @queue,[$x, $y, $cc->[2] + 1];
            $seen{$cv} = 1;
          }
        }
      }
    }
  }
  return -1;
}
