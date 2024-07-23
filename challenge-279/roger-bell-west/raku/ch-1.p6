#! /usr/bin/raku

use Test;

plan 3;

is(sortletters(['R', 'E', 'P', 'L'], [3, 2, 1, 4]), 'PERL', 'example 1');
is(sortletters(['A', 'U', 'R', 'K'], [2, 4, 1, 3]), 'RAKU', 'example 2');
is(sortletters(['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]), 'PYTHON', 'example 3');

sub sortletters(@a, @n) {
    my @out = ["" x @a.elems];
    for @a.kv -> $i, $l {
        @out[@n[$i] - 1] = $l;
    }
    return @out.join('');
}
