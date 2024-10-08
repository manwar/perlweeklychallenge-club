#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(doubleexist([6, 2, 3, 3]), 1, 'example 1');
is(doubleexist([3, 1, 4, 13]), 0, 'example 2');
is(doubleexist([2, 1, 4, 2]), 1, 'example 3');

sub doubleexist($a) {
  foreach my $i (0 .. $#{$a} - 1) {
    foreach my $j ($i + 1 .. $#{$a}) {
      if ($a->[$i] == 2 * $a->[$j] || $a->[$j] == 2 * $a->[$i]) {
        return 1;
      }
    }
  }
  0;
}
