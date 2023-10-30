#! /usr/bin/raku

use Test;

plan 3;

is-deeply(duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]), [1, 0, 0, 2, 3, 0, 0, 4], 'example 1');
is-deeply(duplicatezeros([1, 2, 3]), [1, 2, 3], 'example 2');
is-deeply(duplicatezeros([0, 3, 0, 4, 5]), [0, 0, 3, 0, 0], 'example 3');

sub duplicatezeros(@a) {
    my @out;
    for @a -> $t {
        @out.push($t);
        if ($t == 0) {
            @out.push($t)
        }
        if (@out.elems >= @a.elems) {
            last;
        }
    }
    if (@out.elems > @a.elems) {
        @out.splice(@a.elems);
    }
    return @out;
}
