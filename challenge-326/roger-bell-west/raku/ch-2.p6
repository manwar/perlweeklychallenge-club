#! /usr/bin/raku

use Test;

plan 3;

is-deeply(decompressedlist([1, 3, 2, 4]), [3, 4, 4], 'example 1');
is-deeply(decompressedlist([1, 1, 2, 2]), [1, 2, 2], 'example 2');
is-deeply(decompressedlist([3, 1, 3, 2]), [1, 1, 1, 2, 2, 2], 'example 3');

sub decompressedlist(@a) {
    my @out;
    for @a.rotor(2 => 0) -> @i {
        @out.append(@i[1] xx @i[0]);
    }
    @out;
}
