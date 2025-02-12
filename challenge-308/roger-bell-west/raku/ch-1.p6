#! /usr/bin/raku

use Test;

plan 3;

is(countcommon(['perl', 'weekly', 'challenge'], ['raku', 'weekly', 'challenge']), 2, 'example 1');
is(countcommon(['perl', 'raku', 'python'], ['python', 'java']), 1, 'example 2');
is(countcommon(['guest', 'contribution'], ['fun', 'weekly', 'challenge']), 0, 'example 3');

sub countcommon(@a, @b) {
  my %aa = set(@a);
  my %bb = set(@b);
  (%aa (&) %bb).elems;
}
