#! /usr/bin/raku

use Test;

plan 5;

is(goodsubstrings('abcaefg'), 5, 'example 1');
is(goodsubstrings('xyzzabc'), 3, 'example 2');
is(goodsubstrings('aababc'), 1, 'example 3');
is(goodsubstrings('qwerty'), 4, 'example 4');
is(goodsubstrings('zzzaaa'), 0, 'example 5');

sub goodsubstrings($a) {
    my $p = 0;
    for $a.comb.rotor(3 => -2) -> @s {
        my %c = @s.Bag;
        if (%c.values.max == 1) {
            $p += 1;
        }
    }
    $p;
}
