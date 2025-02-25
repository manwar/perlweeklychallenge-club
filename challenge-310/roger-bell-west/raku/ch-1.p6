#! /usr/bin/raku

use Test;

plan 3;

is-deeply(arraysintersection([[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]]), [1, 4], 'example 1');
is-deeply(arraysintersection([[1, 0, 2, 3], [2, 4, 5]]), [2], 'example 2');
is-deeply(arraysintersection([[1, 2, 3], [4, 5], [6]]), [], 'example 3');

sub arraysintersection(@a) {
    my $s = SetHash.new(@a[0].flat);
    for 1 .. @a.end -> $bi {
        $s = $s (&) Set.new(@a[$bi].flat);
    }
    Array.new($s.keys.sort({$^a <=> $^b}));
}
