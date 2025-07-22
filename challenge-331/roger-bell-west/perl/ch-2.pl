#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 4;

is(buddystrings('fuck', 'fcuk'), 1, 'example 1');
is(buddystrings('love', 'love'), 0, 'example 2');
is(buddystrings('fodo', 'food'), 1, 'example 3');
is(buddystrings('feed', 'feed'), 1, 'example 4');

sub buddystrings($a, $b) {
  my @ac = split '', $a;
  foreach my $i (0 .. $#ac - 1) {
    foreach my $j ($i + 1 .. $#ac) {
      my @acx = split '', $a;;
      $acx[$i] = $ac[$j];
      $acx[$j] = $ac[$i];
      if (join("", @acx) eq $b) {
        return 1;
      }
    }
  }
  0;
}
