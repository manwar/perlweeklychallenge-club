#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is(mindiff([1, 5, 8, 9]), 1, 'example 1');
is(mindiff([9, 4, 1, 7]), 2, 'example 2');

sub mindiff($a) {
  my $md = 0;
  my $n = 0;
  foreach my $i (0 .. $#{$a} - 1) {
    foreach my $j ($i + 1 .. $#{$a}) {
      my $diff = abs($a->[$i] - $a->[$j]);
      if (!$n || $diff < $md) {
        $md = $diff;
        $n = 1;
      }
    }
  }
  $md;
}
