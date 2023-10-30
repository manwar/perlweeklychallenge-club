#! /usr/bin/raku

use Test;

plan 3;

is-deeply(runningsum([1, 2, 3, 4, 5]), [1, 3, 6, 10, 15], 'example 1');
is-deeply(runningsum([1, 1, 1, 1, 1]), [1, 2, 3, 4, 5], 'example 2');
is-deeply(runningsum([0, -1, 1, 2]), [0, -1, 0, 2], 'example 3');

sub runningsum(@a) {
    my @b = @a;
    for 1 .. @a.end -> $i {
        @b[$i] += @b[$i-1];
    }
    return @b;
}
