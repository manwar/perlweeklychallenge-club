#! /usr/bin/raku

use Test;

plan 5;

is(reverseexistence('abcba'), True, 'example 1');
is(reverseexistence('racecar'), True, 'example 2');
is(reverseexistence('abcd'), False, 'example 3');
is(reverseexistence('banana'), True, 'example 4');
is(reverseexistence('hello'), True, 'example 5');

sub reverseexistence($a) {
    my @c = $a.comb.reverse;
    for @c.rotor(2 => -1) -> @d {
        my $sample = @d[0] ~ @d[1];
        with $a.index($sample) -> $dummy {
            return True;
        }
    }
    False;
}
