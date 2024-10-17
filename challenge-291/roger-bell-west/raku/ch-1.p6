#! /usr/bin/raku

use Test;

plan 3;

is(middleindex([2, 3, -1, 8, 4]), 3, 'example 1');
is(middleindex([1, -1, 4]), 2, 'example 2');
is(middleindex([2, 5]), -1, 'example 3');

sub middleindex(@a) {
  my $r = @a.sum;
  my $l = 0;
  for @a.kv -> $i, $c {
    $r -= $c;
    if ($r == $l) {
      return $i;
    }
    $l += $c;
  }
  -1;
}
