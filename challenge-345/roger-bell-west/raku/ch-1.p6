#! /usr/bin/raku

use Test;

plan 5;

is-deeply(peakpositions([1, 3, 2]), [1], 'example 1');
is-deeply(peakpositions([2, 4, 6, 5, 3]), [2], 'example 2');
is-deeply(peakpositions([1, 2, 3, 2, 4, 1]), [2, 4], 'example 3');
is-deeply(peakpositions([5, 3, 1]), [0], 'example 4');
is-deeply(peakpositions([1, 5, 1, 5, 1, 5, 1]), [1, 3, 5], 'example 5');

sub peakpositions(@a) {
    my @out;
    for @a.kv -> $i, $x {
        if (($i == 0 || $x > @a[$i - 1]) &&
            ($i == @a.end || $x > @a[$i + 1])) {
            @out.push($i);
        }
    }
    @out;
}
