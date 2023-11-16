#! /usr/bin/raku

use Test;

plan 2;

is(reversepairs([1, 3, 2, 3, 1]), 2, 'example 1');
is(reversepairs([2, 4, 3, 5, 1]), 3, 'example 2');

sub reversepairs(@a) {
  return @a.combinations(2).grep({ $_[0] > 2 * $_[1]}).elems;
}
