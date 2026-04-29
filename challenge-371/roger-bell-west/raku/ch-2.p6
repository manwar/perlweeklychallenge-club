#! /usr/bin/raku

use Test;

plan 5;

is-deeply(subsetequilibrium([2, 1, 4, 3]), [[1, 4], [2, 1], [2, 3], [4, 3]], 'example 1');
is-deeply(subsetequilibrium([3, 0, 3, 0]), [[3], [3, 0], [3, 0, 3]], 'example 2');
is-deeply(subsetequilibrium([5, 1, 1, 1]), [[5, 1, 1], ], 'example 3');
is-deeply(subsetequilibrium([3, -1, 4, 2]), [[3, -1, 4], [3, 2]], 'example 4');
is-deeply(subsetequilibrium([10, 20, 30, 40]), [], 'example 5');

sub subsetequilibrium(@a) {
    my @out;
    my @b;
    for @a.kv -> $i, $x {
        @b.push($x - $i - 1);
    }
    my @ix = [0 .. @b.elems - 1];
    for 1 .. @b.elems - 1 -> $n {
        for @ix.combinations($n) -> @iy {
            my @bp = @iy.map({@b[$_]});
            if (@bp.sum == 0) {
                my @ap = @iy.map({@a[$_]});
                @out.push(@ap.Array);
            }
        }
    }
    @out.sort().Array;
}
