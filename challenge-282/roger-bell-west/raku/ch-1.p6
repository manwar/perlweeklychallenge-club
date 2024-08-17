#! /usr/bin/raku

use Test;

plan 3;

is(goodinteger(12344456), 444, 'example 1');
is(goodinteger(1233334), -1, 'example 2');
is(goodinteger(10020003), 0, 'example 3');

sub goodinteger($a) {
    my $winsize = 3;
    my @d = $a.comb;
    for @d.rotor($winsize => 1 - $winsize).kv -> $offset, @cc {
        if (@cc[0] == @cc[1] && @cc[1] == @cc[2]) {
            if (($offset == 0 || @d[$offset - 1] != @cc[0]) &&
                ($offset == @d.elems - $winsize || @d[$offset + $winsize]!= @cc[2])) {
                return @cc.join('') + 0;
            }
        }
    }
    -1
}
