#! /usr/bin/perl6

use Test;

plan 2;

is(ib(12,3),8,'example 1');
is(ib(18,4),26,'example 2');

sub ib($m,$n) {
  return $m +^ (1 +< ($n-1));
}
