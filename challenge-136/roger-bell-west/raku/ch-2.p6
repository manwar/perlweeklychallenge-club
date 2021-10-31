#! /usr/bin/perl6

use Test;

plan 3;

is(fibseq(16),4,'example 1');
is(fibseq(9),2,'example 2');
is(fibseq(15),2,'example 3');

sub fibseq($m) {
  return f($m,1,1);
}

sub f($x,$y,$z) {
  if ($x < $y) {
    return 1 if $x==0;
    return 0;
  } else {
    return f($x-$y,$y+$z,$y)+f($x,$y+$z,$y);
  }
}
