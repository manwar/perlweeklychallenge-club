#! /usr/bin/perl6

use Test;

plan 2;

is(jortsort([1,2,3,4,5]),True,'example 1');
is(jortsort([1,3,2,4,5]),False,'example 2');

sub jortsort(@a) {
  for @a.rotor(2 => -1) -> @i {
    if (@i[0] > @i[1]) {
      return False;
    }
  }
  return True;
}
