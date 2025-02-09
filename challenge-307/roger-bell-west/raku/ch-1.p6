#! /usr/bin/raku

use Test;

plan 3;

is-deeply(checkorder([5, 2, 4, 3, 1]), [0, 2, 3, 4], 'example 1');
is-deeply(checkorder([1, 2, 1, 1, 3]), [1, 3], 'example 2');
is-deeply(checkorder([3, 1, 3, 2, 3]), [0, 1, 3], 'example 3');

sub checkorder(@a) {
    my @b = @a.sort({$^a <=> $^b});
    my @out;
    for @b.kv -> $i, $c {
        if (@a[$i] != $c) {
            @out.push($i);
        }
    }
    @out;
}
