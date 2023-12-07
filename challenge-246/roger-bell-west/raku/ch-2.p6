#! /usr/bin/raku

use Test;

plan 3;

is(linearrecurrencesecondorder([1, 1, 2, 3, 5]), True, 'example 1');
is(linearrecurrencesecondorder([4, 2, 4, 5, 7]), False, 'example 2');
is(linearrecurrencesecondorder([4, 1, 2, -3, 8]), True, 'example 3');

sub linearrecurrencesecondorder(@seq) {
  my @a = [@seq[0..2]];
  my @b = [@seq[1..3]];
  my @c = [@seq[2..4]];
  my $q = (@b[2] * @a[0] - @b[0] * @a[2]) div (@b[1] * @a[0] - @b[0] * @a[1]);
  my $p = (@a[2] - @a[1] * $q) div @a[0];
  return $p * @a[0] + $q * @a[1] == @a[2] && $p * @b[0] + $q * @b[1] == @b[2] && $p * @c[0] + $q * @c[1] == @c[2];
}
