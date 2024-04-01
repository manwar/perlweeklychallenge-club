#! /usr/bin/raku

use Test;

plan 3;

is(maximumpairs(['ab', 'de', 'ed', 'bc']), 1, 'example 1');
is(maximumpairs(['aa', 'ba', 'cd', 'ed']), 0, 'example 2');
is(maximumpairs(['uv', 'qp', 'st', 'vu', 'mn', 'pq']), 2, 'example 3');

sub maximumpairs(@a) {
    my $n = 0;
    my $r = SetHash.new;
    for @a -> $s {
        my $t = $s.flip;
        if ($r{$t}:exists) {
            $n++;
        } else {
            $r{$s} = 1;
        }
    }
    return $n;
}
