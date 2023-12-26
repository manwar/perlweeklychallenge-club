#! /usr/bin/raku

use Test;

plan 2;

is-deeply(shortestdistance([3, 2, 3, 2, 2, 2]), [[2, 2], [2, 2], [3, 3]], 'example 1');
is-deeply(shortestdistance([1, 2, 3, 4]), [], 'example 2');

sub shortestdistance(@a0) {
    if (@a0.elems % 2 != 0) {
        return [];
    }
    my @a = @a0.sort({$^a <=> $^b});
    my @out;
    for @a -> $i, $j {
        if ($i != $j) {
            return [];
        }
        @out.push([$i, $i]);
    }
    return @out;
}
