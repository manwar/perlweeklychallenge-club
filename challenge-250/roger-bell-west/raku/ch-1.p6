#! /usr/bin/raku

use Test;

plan 3;

is(smallestindex([0, 1, 2]), 0, 'example 1');
is(smallestindex([4, 3, 2, 1]), 2, 'example 2');
is(smallestindex([1, 2, 3, 4, 5, 6, 7, 8, 9, 0]), -1, 'example 3');

sub smallestindex(@a) {
    for 0 .. @a.end -> $i {
        if (@a[$i] % 10 == $i) {
            return $i;
        }
    }
    return -1;
}
