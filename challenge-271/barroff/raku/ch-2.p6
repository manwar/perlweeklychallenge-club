#!/usr/bin/env raku

use v6.d;

sub sort-by_1-bits(@ints --> Positional) {
    my (%bc, @res);
    map({ push(%bc{$_.base(2).comb.sum}, $_) }, @ints);
    map({ @res.append(sort(%bc{$_})) }, sort(keys(%bc)));
    return @res;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is sort-by_1-bits([0..8]), [0, 1, 2, 4, 8, 3, 5, 6, 7], 'works for [0..8]';
    is sort-by_1-bits([1024, 512, 256, 128, 64]), [64, 128, 256, 512, 1024],
        'works for [1024, 512, 256, 128, 64]';
}

#| Take user provided number like 1024 512 256 128 64
multi sub MAIN(*@ints) {
    say sort-by_1-bits(@ints);
}
