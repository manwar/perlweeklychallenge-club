#! /usr/bin/raku

use Test;

plan 2;

is(maximumaverage([1, 12, -5, -6, 50, 3], 4), 12.75, 'example 1');
is(maximumaverage([5], 1), 5, 'example 2');

sub maximumaverage(@a, $n) {
    my $mx = 0;
    for @a.rotor($n => -($n - 1)) -> @s {
        $mx = ($mx, @s.sum).max;
    }
    $mx / $n;
}
