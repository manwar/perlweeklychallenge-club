#! /usr/bin/raku

use Test;

plan 3;

is(stringscore('hello'), 13, 'example 1');
is(stringscore('perl'), 30, 'example 2');
is(stringscore('raku'), 37, 'example 3');

sub stringscore($a) {
    my $out = 0;
    my @c = $a.comb;
    for @c.rotor(2 => -1) -> @i {
        $out += abs(ord(@i[0]) - ord(@i[1]));
    }
    return $out;
}
