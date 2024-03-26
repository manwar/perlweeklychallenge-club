#! /usr/bin/raku

use Test;

plan 2;

is(countequaldivisible([3, 1, 2, 2, 2, 1, 3], 2), 4, 'example 1');
is(countequaldivisible([1, 2, 3], 1), 0, 'example 2');

sub countequaldivisible(@a, $k) {
    my $s = 0;
    for combinations([0 .. @a.end], 2) -> @c {
        if (@a[@c[0]] == @a[@c[1]] && @c[0] * @c[1] % $k == 0) {
            $s++;
        }
    }
    return $s;
}
