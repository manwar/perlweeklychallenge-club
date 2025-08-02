#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(xmatrix([[1, 0, 0, 2], [0, 3, 4, 0], [0, 5, 6, 0], [7, 0, 0, 1]]), 1, 'example 1');
is(xmatrix([[1, 2, 3], [4, 5, 6], [7, 8, 9]]), 0, 'example 2');
is(xmatrix([[1, 0, 2], [0, 3, 0], [4, 0, 5]]), 1, 'example 3');

sub xmatrix($a) {
  my $order = scalar @{$a} - 1;
  my $valid = 1;
  foreach my $y (0 .. $#{$a}) {
    foreach my $x (0 .. $#{$a->[$y]}) {
      if ($x == $y || $x == $order - $y) {
        if ($a->[$y][$x] == 0) {
          $valid = 0;
        }
      } else {
        if ($a->[$y][$x] != 0) {
          $valid = 0;
        }
      }
      unless ($valid) {
        last;
      }
    }
    unless ($valid) {
      last;
    }
  }
  return $valid;
}
