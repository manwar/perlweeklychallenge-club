#! /usr/bin/raku

use Test;

plan 3;

is(doubleexist([6, 2, 3, 3]), True, 'example 1');
is(doubleexist([3, 1, 4, 13]), False, 'example 2');
is(doubleexist([2, 1, 4, 2]), True, 'example 3');

sub doubleexist(@a) {
    for @a.combinations(2) -> @i {
        if (@i[0] == 2 * @i[1] || @i[1] == 2 * @i[0]) {
            return True;
        }
    }
    False;
}
