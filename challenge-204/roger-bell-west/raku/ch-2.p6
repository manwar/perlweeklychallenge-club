#! /usr/bin/raku

use Test;

plan 3;

is-deeply(reshapematrix([[1, 2], [3, 4]], 1, 4), [[1, 2, 3, 4], ], 'example 1');
is-deeply(reshapematrix([[1, 2, 3], [4, 5, 6]], 3, 2), [[1, 2], [3, 4], [5, 6]], 'example 2');
is-deeply(reshapematrix([[1, 2]], 3, 2), [[0,],], 'example 3');

sub reshapematrix(@m, $r, $c) {
    my @mv = @m».List.flat;
    if ($r * $c != @mv.elems) {
        return [[0,],];
    }
    my @out;
    for (0 .. $r-1) -> $i {
        @out.push(@mv[$i * $c .. ($i + 1) * $c - 1].Array);
    }
    return @out;
}
