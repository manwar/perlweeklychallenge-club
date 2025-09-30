#! /usr/bin/raku

use Test;

plan 5;

is(duplicateremovals('abbaca'), 'ca', 'example 1');
is(duplicateremovals('azxxzy'), 'ay', 'example 2');
is(duplicateremovals('aaaaaaaa'), '', 'example 3');
is(duplicateremovals('aabccba'), 'a', 'example 4');
is(duplicateremovals('abcddcba'), '', 'example 5');

sub duplicateremovals($a) {
  my @b;
  for $a.comb -> $c {
    if (@b.elems == 0 || $c ne @b[*-1]) {
      @b.push($c);
    } else {
      @b.pop;
    }
  }
  join('', @b);
}
