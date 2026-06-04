#! /usr/bin/raku

use Test;

plan 5;

is(chessboardsquares('a7', 'f4'), True, 'example 1');
is(chessboardsquares('c1', 'e8'), False, 'example 2');
is(chessboardsquares('b5', 'h2'), False, 'example 3');
is(chessboardsquares('f3', 'h1'), True, 'example 4');
is(chessboardsquares('a1', 'g8'), False, 'example 5');

sub cs2xy($a) {
  my @c = $a.comb;
  my $x = ord(@c[0]) - ord('a');
  my $y = ord(@c[1]) - ord('1');
  return [$x, $y];
}

sub checkcolor($a) {
  my @xy = cs2xy($a);
  return (@xy[0] + @xy[1]) % 2 == 1;
}

sub chessboardsquares($a, $b) {
    checkcolor($a) == checkcolor($b);
}
