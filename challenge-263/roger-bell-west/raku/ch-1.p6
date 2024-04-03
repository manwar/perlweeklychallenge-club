#! /usr/bin/raku

use Test;

plan 3;

is-deeply(targetindex([1, 5, 3, 2, 4, 2], 2), [1, 2], 'example 1');
is-deeply(targetindex([1, 2, 4, 3, 5], 6), [], 'example 2');
is-deeply(targetindex([5, 3, 2, 4, 2, 1], 4), [4], 'example 3');

sub targetindex(@a0, $k) {
    my @a = @a0.sort({$^a <=> $^b});
    return [(0 .. @a.end).grep({@a[$_] == $k})];
}
