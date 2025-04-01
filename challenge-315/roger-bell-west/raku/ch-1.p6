#! /usr/bin/raku

use Test;

plan 3;

is-deeply(findwords(['the', 'weekly', 'challenge'], 'e'), [0, 1, 2], 'example 1');
is-deeply(findwords(['perl', 'raku', 'python'], 'p'), [0, 2], 'example 2');
is-deeply(findwords(['abc', 'def', 'bbb', 'bcd'], 'b'), [0, 2, 3], 'example 3');

sub findwords(@a, $b) {
    my @out;
    for @a.kv -> $i, $x {
        with $x.index($b) -> $ix {
            @out.push($i);
        }
    }
    @out;
}
