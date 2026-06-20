#! /usr/bin/raku

use Test;

plan 6;

is(sumofwords('acb', 'cba', 'cdb'), True, 'example 1');
is(sumofwords('aab', 'aac', 'ad'), True, 'example 2');
is(sumofwords('bc', 'je', 'jg'), False, 'example 3');
is(sumofwords('a', 'aaaa', 'aa'), True, 'example 4');
is(sumofwords('c', 'd', 'h'), False, 'example 5');
is(sumofwords('gfi', 'hbf', 'bdhd'), True, 'example 6');

sub l2n($a) {
  my $a0 = ord('a');
  my $t = 0;
  for $a.comb -> $c {
    $t *= 10;
    $t += ord($c) - $a0;
  }
  $t;
}

sub sumofwords($a, $b, $c) {
  l2n($a) + l2n($b) == l2n($c);
}
