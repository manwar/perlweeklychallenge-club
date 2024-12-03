#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(maximalsquare([[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]), 4, 'example 1');
is(maximalsquare([[0, 1], [1, 0]]), 1, 'example 2');
is(maximalsquare([[0]]), 0, 'example 3');

use List::Util qw(min max);

sub maximalsquare($a) {
  my $mx = 0;
  my $boundy = scalar @{$a};
  my $boundx = scalar @{$a->[0]};
  foreach my $y (0 .. $boundy - 1) {
    foreach my $x (0 .. $boundx - 1) {
      my $size = 0;
      while (1) {
        my @tests;
        foreach my $xx ($x.. $x + $size) {
          push @tests, [$y + $size, $xx];
        }
        if ($size > 0) {
          foreach my $yy ($y .. $y + $size) {
            push @tests, [$yy, $x + $size];
          }
        }
        if (min(map {$a->[$_->[0]][$_->[1]]} @tests) == 0) {
          last;
        }
        $size++;
        if ($x + $size >= $boundx || $y + $size >= $boundy) {
          last;
        }
      }
      $mx = max($mx, $size * $size);
    }
  }
  $mx;
}
