#!/usr/bin/env raku

use v6.d;

sub special-positions(@ints --> Int) {
    my @special-rows = grep({ sum(@ints[$_]) == 1 }, 0..@ints.elems - 1);
    my &special-columns = sub ($i) {
        my $column = @ints[$i].first: * == 1, :k;
        sum(map({ @ints[$_][$column]}, 0..@ints.elems - 1));
    }
    grep({ &special-columns($_) == 1 }, @special-rows).elems;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is special-positions([ [1, 0, 0],
                           [0, 0, 1],
                           [1, 0, 0],
                         ]), 1, 'works for first matrix';
    is special-positions([ [1, 0, 0],
                           [0, 1, 0],
                           [0, 0, 1],
                         ]), 3, 'works for second matrix';
}
