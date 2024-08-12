#! /usr/bin/raku

use Test;

plan 3;

is(checkcolor('d3'), True, 'example 1');
is(checkcolor('g5'), False, 'example 2');
is(checkcolor('e6'), True, 'example 3');

sub cs2xy($a) {
  my @c = $a.comb;
  my $x = ord(@c[0]) - ord('a');
  my $y = ord(@c[1]) - ord('1');
  return [$x, $y];
}

sub checkcolor($a) {
  my @xy = cs2xy($a);
  return (@xy[0] + @xy[1]) % 2 == 1;
}
