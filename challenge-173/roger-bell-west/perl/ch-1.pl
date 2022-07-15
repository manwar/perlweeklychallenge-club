#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(esthetic10(5456),
   1,
   'example 1');

is(esthetic10(120),
   0,
   'example 2');

is(esthetic10(12),
   1,
   'example 3');

is(esthetic10(5654),
   1,
   'example 4');

is(esthetic10(890),
   0,
   'example 5');

sub esthetic10($n) {
  return esthetic($n,10);
}

sub esthetic($n0,$base) {
  my $n = $n0;
  my $pdigit;
  my $ch = 0;
  while ($n > 0) {
    my $digit = $n % $base;
    if ($ch && abs($digit - $pdigit) != 1) {
      return 0;
    }
    $ch = 1;
    $pdigit = $digit;
    $n = int($n / $base);
  }
  return 1;
}
