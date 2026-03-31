#! /usr/bin/raku

use Test;

plan 5;

is(countprefixes(['a', 'ap', 'app', 'apple', 'banana'], 'apple'), 4, 'example 1');
is(countprefixes(['cat', 'dog', 'fish'], 'bird'), 0, 'example 2');
is(countprefixes(['hello', 'he', 'hell', 'heaven', 'he'], 'hello'), 4, 'example 3');
is(countprefixes(['', 'code', 'coding', 'cod'], 'coding'), 3, 'example 4');
is(countprefixes(['p', 'pr', 'pro', 'prog', 'progr', 'progra', 'program'], 'program'), 7, 'example 5');

sub countprefixes(@a, $b) {
  @a.grep({$b.starts-with($_)}).elems;
}
