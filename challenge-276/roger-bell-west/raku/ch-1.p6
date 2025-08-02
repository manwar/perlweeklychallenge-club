#! /usr/bin/raku

use Test;

plan 3;

is(completeday([12, 12, 30, 24, 24]), 2, 'example 1');
is(completeday([72, 48, 24, 5]), 3, 'example 2');
is(completeday([12, 18, 24]), 0, 'example 3');

sub completeday(@a) {
    return @a.combinations(2).grep({($_[0] + $_[1]) % 24 == 0 }).elems;
}
