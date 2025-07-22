#! /usr/bin/raku

use Test;

plan 4;

is(buddystrings('fuck', 'fcuk'), True, 'example 1');
is(buddystrings('love', 'love'), False, 'example 2');
is(buddystrings('fodo', 'food'), True, 'example 3');
is(buddystrings('feed', 'feed'), True, 'example 4');

sub buddystrings($a, $b) {
    my @ac = $a.comb;
    for (0 .. @ac.elems - 2) -> $i {
        for ($i + 1 .. @ac.elems - 1) -> $j {
            my @acx = $a.comb;
            @acx[$i] = @ac[$j];
            @acx[$j] = @ac[$i];
            if (@acx.join("") eq $b) {
                return True;
            }
        }
    }
    False;
}
