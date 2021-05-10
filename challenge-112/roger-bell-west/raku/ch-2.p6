#! /usr/bin/perl6

use Test;

plan 3;

is(cs(3),3,'example 1');
is(cs(4),5,'example 2');
is(cs(20),10946,'example 3');

sub cs($i) {
  my ($a,$b,$c)=(0,1,0);
  for 1..$i {
    $c=$a+$b;
    ($a,$b)=($b,$c);
  }
  return $c;
}
