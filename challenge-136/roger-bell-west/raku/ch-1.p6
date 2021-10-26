#! /usr/bin/perl6

use Test;

plan 4;

is(twofriendly(8,24),1,'example 1');
is(twofriendly(26,39),0,'example 2');
is(twofriendly(4,10),1,'example 3');
is(twofriendly(1,2),0,'example 4');

sub ispower2($n) {
  if ($n < 2) {
    return 0;
  }
  return ($n +& ($n-1))==0;
}

sub twofriendly($m,$n) {
  return ispower2($m gcd $n) ?? 1 !! 0;
}
