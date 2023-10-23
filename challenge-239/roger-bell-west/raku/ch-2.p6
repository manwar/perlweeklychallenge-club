#! /usr/bin/raku

use Test;

plan 3;

is(consistentstrings(['ad', 'bd', 'aaab', 'baa', 'badab'], 'ab'), 2, 'example 1');
is(consistentstrings(['a', 'b', 'c', 'ab', 'ac', 'bc', 'abc'], 'ab'), 3, 'example 2');
is(consistentstrings(['cc', 'acd', 'b', 'ba', 'bac', 'bad', 'ac', 'd'], 'cad'), 4, 'example 3');

sub consistentstrings(@a, $v) {
    my $vs = $v.comb.Set;
    return @a.grep({$vs{$_.comb.Set.keys.all}:exists}).elems;
}
