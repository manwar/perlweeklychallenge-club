#! /usr/bin/raku

use Test;

plan 2;

is-deeply(commoncharacters(['Perl', 'Rust', 'Raku']), ['r'], 'example 1');
is-deeply(commoncharacters(['love', 'live', 'leave']), ['e', 'l', 'v'], 'example 2');

sub word2set($word) {
  return SetHash($word.lc.comb.grep(/<[a..z]>/));
}

sub commoncharacters(@lst) {
    my $c = word2set(@lst[0]);
    for @lst.skip(1) -> $w {
        $c (&)= word2set($w);
    }
    return $c.keys.sort.Array;
}
