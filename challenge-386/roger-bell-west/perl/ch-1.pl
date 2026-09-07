#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(reversebase('101010', 2), 42, 'example 1');
is(reversebase('EEADEE', 16), 15642094, 'example 2');
is(reversebase('755', 8), 493, 'example 3');
is(reversebase('1BRJB', 36), 2228519, 'example 4');
is(reversebase('7MyqL', 64), 123456789, 'example 5');

sub reversebase($a, $base) {
  my @digits = ('0' .. '9', 'A' .. 'Z', 'a' .. 'z', '+', '/');
  my %dd;
  foreach my $i (0 .. $#digits) {
    $dd{$digits[$i]} = $i;
  }
  my $ov = 0;
  foreach my $c (split '', $a) {
    $ov *= $base;
    $ov += $dd{$c};
  }
  $ov;
}
