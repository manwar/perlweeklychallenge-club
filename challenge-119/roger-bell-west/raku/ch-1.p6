#! /usr/bin/perl6

use Test;

plan 2;

is(sn(101),86,'example 1');
is(sn(18),33,'example 2');

sub sn($n) {
  return 16*($n mod 16)+($n div 16);
}
