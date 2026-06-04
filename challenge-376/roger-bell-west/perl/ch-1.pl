#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(chessboardsquares('a7', 'f4'), 1, 'example 1');
is(chessboardsquares('c1', 'e8'), 0, 'example 2');
is(chessboardsquares('b5', 'h2'), 0, 'example 3');
is(chessboardsquares('f3', 'h1'), 1, 'example 4');
is(chessboardsquares('a1', 'g8'), 0, 'example 5');


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

sub chessboardsquares($a, $b) {
    (checkcolor($a) == checkcolor($b))?1:0;
}
