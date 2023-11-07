#! /usr/bin/raku

use Test;

plan 2;

is-deeply(flipmatrix([[1, 1, 0], [1, 0, 1], [0, 0, 0]]), [[1, 0, 0], [0, 1, 0], [1, 1, 1]], 'example 1');
is-deeply(flipmatrix([[1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0]]), [[1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0]], 'example 2');

sub flipmatrix(@a) {
  return @a.map({$_.map({1 - $_}).reverse.Array}).Array;
}
