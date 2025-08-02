#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 3;

is(checkcolor('d3'), 1, 'example 1');
is(checkcolor('g5'), 0, 'example 2');
is(checkcolor('e6'), 1, 'example 3');

sub cs2xy($a) {
  my @c = split('', $a);
  my $x = ord($c[0]) - ord('a');
  my $y = ord($c[1]) - ord('1');
  return [$x, $y];
}

sub checkcolor($a) {
  my $xy = cs2xy($a);
  return (($xy->[0] + $xy->[1]) % 2 == 1)?1:0;
}
