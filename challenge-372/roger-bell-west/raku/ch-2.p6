#! /usr/bin/raku

use Test;

plan 5;

is(largestsubstring('aaaaa'), 3, 'example 1');
is(largestsubstring('abcdeba'), 5, 'example 2');
is(largestsubstring('abbc'), 0, 'example 3');
is(largestsubstring('abcaacbc'), 4, 'example 4');
is(largestsubstring('laptop'), 2, 'example 5');

sub largestsubstring($a) {
  my @cc = $a.comb;
  for reverse(1 .. @cc.end) -> $offset {
    for 0 .. @cc.end - $offset -> $x {
      if (@cc[$x] eq @cc[$x + $offset]) {
        return $offset - 1;
      }
    }
  }
  -1;
}
