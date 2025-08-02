#! /usr/bin/raku

use Test;

plan 3;

is-deeply(twodarray([1, 2, 3, 4], 2, 2), [[1, 2], [3, 4]], 'example 1');
is-deeply(twodarray([1, 2, 3], 1, 3), [[1, 2, 3],], 'example 2');
is-deeply(twodarray([1, 2, 3, 4], 4, 1), [[1], [2], [3], [4]], 'example 3');

sub twodarray(@i, $r, $c) {
    my @out;
    for @i.kv -> $ct, $n {
        if ($ct % $c == 0) {
            @out.push([]);
        }
        @out[*-1].push($n);
    }
    @out
}
