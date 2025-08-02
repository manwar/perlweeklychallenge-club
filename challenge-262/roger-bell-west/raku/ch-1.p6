#! /usr/bin/raku

use Test;

plan 3;

is(maxpositivenumber([-3, 1, 2, -1, 3, -2, 4]), 4, 'example 1');
is(maxpositivenumber([-1, -2, -3, 1]), 3, 'example 2');
is(maxpositivenumber([1, 2]), 2, 'example 3');

sub maxpositivenumber(@a) {
    return max(
        @a.grep({$_ > 0}).elems,
        @a.grep({$_ < 0}).elems,
    );
}
