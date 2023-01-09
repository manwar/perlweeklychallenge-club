#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(goodtriplets([3, 0, 1, 1, 9, 7], 7, 2, 3), 4, 'example 1');
is(goodtriplets([1, 1, 2, 2, 3], 0, 0, 1), 0, 'example 2');

sub goodtriplets($a, $x, $y, $z) {
  my $c = 0;
  foreach my $i (0..$#{$a} - 2) {
    foreach my $j ($i+1..$#{$a} - 1) {
      if (abs($a->[$i] - $a->[$j]) <= $x) {
        foreach my $k ($j+1..$#{$a}) {
          if (abs($a->[$j] - $a->[$k]) <= $y &&
              abs($a->[$i] - $a->[$k]) <= $z) {
            $c++;
          }
        }
      }
    }
  }
  return $c;
}
