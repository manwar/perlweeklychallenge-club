#! /usr/bin/perl6

use Test;

plan 2;

is(seob(101),154,'example 1');
is(seob(18),33,'example 2');

sub seob($n) {
  return (($n +& 0x55)+<1) +| (($n +& 0xAA)+>1);
}
