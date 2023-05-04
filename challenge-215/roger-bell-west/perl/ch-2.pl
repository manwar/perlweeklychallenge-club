#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(numberplacement([1, 0, 0, 0, 1], 1), 1, 'example 1');
is(numberplacement([1, 0, 0, 0, 1], 2), 0, 'example 2');
is(numberplacement([1, 0, 0, 0, 0, 0, 0, 0, 1], 3), 1, 'example 3');

sub numberplacement($a0, $ct) {
  my @a = (1, @{$a0}, 1);
  my $s = 0;
  my $tt = 0;
  foreach my $i (1..$#a) {
    if ($a[$i - 1] == 1 && $a[$i] == 0) {
      $s = $i;
    } elsif ($a[$i - 1] == 0 && $a[$i] == 1) {
      $tt += int(($i - $s)/2);
    }
  }
  return ($ct <= $tt)?1:0;
}
