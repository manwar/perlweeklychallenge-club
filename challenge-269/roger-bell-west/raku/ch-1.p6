#! /usr/bin/raku

use Test;

plan 3;

is(bitwiseor([1, 2, 3, 4, 5]), True, 'example 1');
is(bitwiseor([2, 3, 8, 16]), True, 'example 2');
is(bitwiseor([1, 2, 5, 7, 9]), False, 'example 3');

sub bitwiseor(@a) {
    return @a.grep({$_ % 2 == 0}).elems >= 2;
}
