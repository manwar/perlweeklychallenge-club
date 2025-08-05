#! /usr/bin/raku

use Test;

plan 5;

is-deeply(duplicatezeros([1, 0, 2, 3, 0, 4, 5, 0]), [1, 0, 0, 2, 3, 0, 0, 4], 'example 1');
is-deeply(duplicatezeros([1, 2, 3]), [1, 2, 3], 'example 2');
is-deeply(duplicatezeros([1, 2, 3, 0]), [1, 2, 3, 0], 'example 3');
is-deeply(duplicatezeros([0, 0, 1, 2]), [0, 0, 0, 0], 'example 4');
is-deeply(duplicatezeros([1, 2, 0, 3, 4]), [1, 2, 0, 0, 3], 'example 5');

sub duplicatezeros(@a) {
    my @b;
    for @a -> $n {
        @b.push($n);
        if (@a.elems == @b.elems) {
            last;
        }
        if ($n == 0) {
            @b.push(0);
            if (@a.elems == @b.elems) {
                last;
            }
        }
    }
    @b;
}
