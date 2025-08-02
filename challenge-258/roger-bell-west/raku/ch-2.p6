#! /usr/bin/raku

use Test;

plan 3;

is(sumofvalues([2, 5, 9, 11, 3], 1), 17, 'example 1');
is(sumofvalues([2, 5, 9, 11, 3], 2), 11, 'example 2');
is(sumofvalues([2, 5, 9, 11, 3], 0), 2, 'example 3');

sub popcount64($x0) {
  constant $M1  = 0x5555555555555555;
  constant $M2  = 0x3333333333333333;
  constant $M4  = 0x0f0f0f0f0f0f0f0f;
  constant $H01 = 0x0101010101010101;
  my $x = $x0;
  $x -= ($x +> 1) +& $M1;
  $x = ($x +& $M2) + (($x +> 2) +& $M2);
  $x = ($x + ($x +> 4)) +& $M4;
  return ($x * $H01) +> 56;
}

sub sumofvalues(@a, $k) {
  return (0 .. @a.end).grep({popcount64($_) == $k}).map({@a[$_]}).sum;
}
