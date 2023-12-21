#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(submatrixsum([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]), [[14, 18, 22], [30, 34, 38]], 'example 1');
is_deeply(submatrixsum([[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]), [[2, 1, 0], [1, 2, 1], [0, 1, 2]], 'example 2');

sub submatrixsum($a) {
  my @out;
  foreach my $y (0 .. $#{$a} - 1) {
    my @row;
    foreach my $x (0 .. $#{$a->[$y]} - 1) {
      my $s = 0;
      foreach my $ya ($y, $y + 1) {
        foreach my $xa ($x, $x + 1) {
          $s += $a->[$ya][$xa];
        }
      }
      push @row, $s;
    }
    push @out, \@row;
  }
  return \@out;
}
