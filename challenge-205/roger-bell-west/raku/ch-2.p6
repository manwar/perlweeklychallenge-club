#! /usr/bin/raku

use Test;

plan 3;

is(maximumxor([1, 2, 3, 4, 5, 6, 7]), 7, 'example 1');
is(maximumxor([2, 4, 1, 3]), 7, 'example 2');
is(maximumxor([10, 5, 7, 12, 8]), 15, 'example 3');

sub maximumxor(@l) {
    my @ct;
    for @l.combinations(2) -> @c {
        @ct.push(@c[0] +^ @c[1]);
    }
    return @ct.max;
}
