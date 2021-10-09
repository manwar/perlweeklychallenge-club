#! /usr/bin/perl

use strict;

use Test::More tests => 4;

is(isqrt(10),3,'example 1');
is(isqrt(27),5,'example 1');
is(isqrt(85),9,'example 1');
is(isqrt(101),10,'example 1');

sub isqrt {
  my $n=shift;
  my $k=$n>>1;
  my $x=1;
  while ($x) {
    my $k1=($k+$n/$k) >> 1;
    if ($k1 >= $k) {
      $x=0;
    }
    $k=$k1;
  }
  return $k;
}
