#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(toeplitzmatrix([[4, 3, 2, 1], [5, 4, 3, 2], [6, 5, 4, 3]]), 1, 'example 1');
is(toeplitzmatrix([[1, 2, 3], [3, 2, 1]]), 0, 'example 2');

sub toeplitzmatrix($a) {
  my $ym = $#{$a};
  my $xm = $#{$a->[0]};
  my $toeplitz = 1;
  foreach my $xb ((1 - $xm)..($ym - 1)) {
    my $init = 1;
    my $tv = 0;
    foreach my $x ($xb .. $xb + $xm) {
      if ($x >= 0 && $x <= $xm) {
        my $y = $x - $xb;
        if ($y >= 0 && $y <= $ym) {
          if ($init) {
            $init = 0;
            $tv = $a->[$y][$x];
          } elsif ($a->[$y][$x] != $tv) {
            $toeplitz = 0;
            last;
          }
        }
      }
    }
    unless ($toeplitz) {
      last;
    }
  }
  return $toeplitz;
}
