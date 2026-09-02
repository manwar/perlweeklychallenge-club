#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(zigzagsubarray([9, 4, 2, 10, 7, 8, 8, 1, 9]), 5, 'example 1');
is(zigzagsubarray([1, 7, 4, 9, 2, 5]), 6, 'example 2');
is(zigzagsubarray([1, 2, 3, 4, 5]), 2, 'example 3');
is(zigzagsubarray([4, 4, 4]), 1, 'example 4');
is(zigzagsubarray([10, 20, 15, 12, 18]), 3, 'example 5');

use List::Util qw(min max);

sub zigzagsubarray($a) {
  my $mx = min(1, scalar @{$a});
  foreach my $i (0 .. $#{$a}) {
    my $o = 0;
    my $lastdir = 0;
    foreach my $j ($i .. $#{$a}) {
      my $thisdir = 0;
      if ($j > $i) {
        if ($a->[$j] > $o) {
          $thisdir = 1;
          $mx = max($mx, 2);
        } elsif ($a->[$j] < $o) {
          $thisdir = -1;
          $mx = max($mx, 2);
        }
      }
      if (($j > $i && $thisdir == 0) || ($j > $i + 1 && $thisdir * $lastdir != -1)) {
        last;
      }
      $o = $a->[$j];
      $lastdir = $thisdir;
      $mx = max($mx, $j - $i + 1);
    }
  }
  $mx;
}
