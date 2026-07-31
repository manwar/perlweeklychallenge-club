#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(basen(42, 2), '101010', 'example 1');
is(basen(15642094, 16), 'EEADEE', 'example 2');
is(basen(493, 8), '755', 'example 3');
is(basen(2228519, 36), '1BRJB', 'example 4');
is(basen(123456789, 64), '7MyqL', 'example 5');

sub basen($a, $base) {
  if ($a == 0) {
    return "0";
  }
  my @digits = ('0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/');
  my @fields;
  my $aa = $a;
  while ($aa > 0) {
    push @fields, $aa % $base;
    $aa = int($aa / $base);
  }
  my $output = '';
  while (scalar @fields > 0) {
    $output .= @digits[pop @fields];
  }
  $output;
}
