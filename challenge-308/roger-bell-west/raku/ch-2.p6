#! /usr/bin/raku

use Test;

plan 2;

is-deeply(decodexor([1, 2, 3], 1), [1, 0, 2, 1], 'example 1');
is-deeply(decodexor([6, 2, 7, 3], 4), [4, 2, 0, 7, 4], 'example 2');

sub decodexor(@a, $init) {
  my @out = [$init];
  for @a -> $v {
    @out.push(@out[*-1] +^ $v);
  }
  @out;
}
