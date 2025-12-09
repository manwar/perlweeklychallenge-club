#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(arithmeticprogression([1, 3, 5, 7, 9]), 1, 'example 1');
is(arithmeticprogression([9, 1, 7, 5, 3]), 1, 'example 2');
is(arithmeticprogression([1, 2, 4, 8, 16]), 0, 'example 3');
is(arithmeticprogression([5, -1, 3, 1, -3]), 1, 'example 4');
is(arithmeticprogression([1.5, 3, 0, 4.5, 6]), 1, 'example 5');

sub arithmeticprogression($a) {
  my $epsilon = 0.0001;
  my @a = sort {$::a <=> $::b} @{$a};
  my $delta = $a[1] - $a[0];
  foreach my $i (2 .. $#a) {
    if (abs($a[$i] - $a[$i - 1] - $delta) > $epsilon) {
      return 0;
    }
  }
  return 1;
}
