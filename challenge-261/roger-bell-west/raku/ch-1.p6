#! /usr/bin/raku

use Test;

plan 4;

is(elementdigitsum([1, 2, 3, 45]), 36, 'example 1');
is(elementdigitsum([1, 12, 3]), 9, 'example 2');
is(elementdigitsum([1, 2, 3, 4]), 0, 'example 3');
is(elementdigitsum([236, 416, 336, 350]), 1296, 'example 4');

sub elementdigitsum(@a) {
  my $delta = 0;
  for @a -> $n0 {
    my $n = $n0 div 10;
    my $m = 10;
    while ($n > 0) {
      $delta += ($n % 10) * ($m - 1);
      $n = $n div 10;
      $m *= 10;
    }
  }
  return $delta;
}
