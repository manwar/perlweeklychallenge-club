#! /usr/bin/perl6

use Test;

plan 4;

is(isqrt(10),3,'example 1');
is(isqrt(27),5,'example 1');
is(isqrt(85),9,'example 1');
is(isqrt(101),10,'example 1');

sub isqrt($n) {
  my $k=$n +> 1;
  my $x=1;
  while ($x) {
    my $k1=($k+$n/$k) +> 1;
    if ($k1 >= $k) {
      $x=0;
    }
    $k=$k1;
  }
  return $k;
}
