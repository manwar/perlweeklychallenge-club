#! /usr/bin/raku

use Test;

plan 3;

is(circular(['perl', 'loves', 'scala']), True, 'example 1');
is(circular(['love', 'the', 'programming']), False, 'example 2');
is(circular(['java', 'awk', 'kotlin', 'node.js']), True, 'example 3');

sub circular(@a) {
    for @a.rotor(2 => -1) -> @p {
        if (substr(@p[0], *-1, 1) ne substr(@p[1], 0, 1)) {
            return False;
        }
    }
    True;
}
