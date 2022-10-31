#! /usr/bin/perl6

use Test;

plan 5;

is(greatercharacter(['e', 'm', 'u', 'g'], 'b'), 'e', 'example 1');
is(greatercharacter(['d', 'c', 'e', 'f'], 'a'), 'c', 'example 2');
is(greatercharacter(['j', 'a', 'r'], 'o'), 'r', 'example 3');
is(greatercharacter(['d', 'c', 'a', 'f'], 'a'), 'c', 'example 4');
is(greatercharacter(['t', 'g', 'a', 'l'], 'v'), 'v', 'example 5');

sub greatercharacter(@a, $k) {
    my @aa = @a.grep({$_ gt $k}).sort;
    if (@aa) {
        return @aa[0];
    } else {
        return $k;
    }
}
