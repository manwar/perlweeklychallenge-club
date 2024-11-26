#! /usr/bin/raku

use Test;

plan 4;

is(contiguousarray([1, 0]), 2, 'example 1');
is(contiguousarray([0, 1, 0]), 2, 'example 2');
is(contiguousarray([0, 0, 0, 0, 0]), 0, 'example 3');
is(contiguousarray([0, 1, 0, 0, 1, 0]), 4, 'example 4');

sub contiguousarray(@a) {
    my $lm = (1 + @a.elems) div 2 * 2;
    loop (my $l = $lm; $l >= 2; $l -= 2) {
        for (0 .. @a.elems - $l) -> $start {
            my $end = $start + $l - 1;
            if (sum(@a[$start .. $end]) * 2 == $l) {
                return $l;
            }
        }
    }
    0;
}
