#! /usr/bin/raku

use Test;

plan 3;

is-deeply(targetarray([0, 1, 2, 3, 4], [0, 1, 2, 2, 1]), [0, 4, 1, 3, 2], 'example 1');
is-deeply(targetarray([1, 2, 3, 4, 0], [0, 1, 2, 3, 0]), [0, 1, 2, 3, 4], 'example 2');
is-deeply(targetarray([1], [0]), [1], 'example 3');

sub targetarray(@a, @indices) {
    my @c;
    for @indices.kv -> $i, $ix {
        if ($ix == @c.elems) {
            @c.push(@a[$i]);
        } else {
            @c.splice($ix, 0, @a[$i]);
        }
    }
    return @c;
}
