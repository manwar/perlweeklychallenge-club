#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(removeone([0, 2, 9, 4, 6]), 1, 'example 1');
is(removeone([5, 1, 3, 2]), 0, 'example 2');
is(removeone([2, 2, 3]), 1, 'example 3');

sub removeone($a) {
  my $ec = 0;
  my $le = 1 + $a->[1] - $a->[0];
  foreach my $i (0..$#{$a}-1) {
    my @s = ($a->[$i], $a->[$i+1]);
    if ($s[1] <= $s[0]) {
      $ec++;
      if ($ec > 1 || $s[0] - $s[1] >= $le) {
        return 0;
      }
    }
    $le = $s[1] - $s[0];
  }
  return 1;
}
