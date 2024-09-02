#! /usr/bin/raku

use Test;

plan 3;

is(luckyinteger([2, 2, 3, 4]), 2, 'example 1');
is(luckyinteger([1, 2, 2, 3, 3, 3]), 3, 'example 2');
is(luckyinteger([1, 1, 1, 3]), -1, 'example 3');

sub luckyinteger(@a) {
    my %c;
    @a.map({%c{$_}++});
    my @c1 = %c.values.sort.reverse;
    my @c2 = %c.keys.sort.reverse;
    for @c1 -> $v1 {
        for @c2 -> $v2 {
            if (%c{$v2} == $v1 && $v1 == $v2) {
                return $v2;
            }
        }
    }
    return -1;
}
