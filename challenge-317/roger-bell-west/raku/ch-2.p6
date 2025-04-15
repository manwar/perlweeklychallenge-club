#! /usr/bin/raku

use Test;

plan 4;

is(friendlystrings('desc', 'dsec'), True, 'example 1');
is(friendlystrings('fuck', 'fcuk'), True, 'example 2');
is(friendlystrings('poo', 'eop'), False, 'example 3');
is(friendlystrings('stripe', 'sprite'), True, 'example 4');

sub friendlystrings($a, $b) {
    for 0 ..  $a.chars - 2 -> $i {
        for $i + 1 ..  $a.chars - 1 -> $j {
            my @c = $a.comb;
            @c[$i] = substr($a, $j, 1);
            @c[$j] = substr($a, $i, 1);
            if (@c.join("") eq $b) {
                return True;
            }
        }
    }
    False;
}
