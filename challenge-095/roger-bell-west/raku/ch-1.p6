#! /usr/bin/perl6

use Test;

plan 3;

is(pn(1221),1,'example 1');
is(pn(-101),0,'example 2');
is(pn(90),0,'example 3');

sub pn($n) {
  if ($n.comb.reverse.join('') eq $n) {
    return 1;
  } else {
    return 0;
  }
}
