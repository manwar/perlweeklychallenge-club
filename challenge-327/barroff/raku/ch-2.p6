#!/usr/bin/env raku

use v6.d;

sub mad(@ints where @ints.elems == @ints.unique.elems --> Array) {
    my %differences;

    map({ %differences{abs(@_[0] - @_[1])}.push(@_.sort) }, @ints.combinations: 2);
    return %differences{
        min(
            %differences.keys,
            :by({ Int($_) })
        )
    };
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is sort(mad([4, 1, 2, 3])), [[1, 2], [2, 3], [3, 4]], 'works for "[4, 1, 2, 3]"';
    is sort(mad([1, 3, 7, 11, 15])), [[1, 3]], 'works for "[1, 3, 7, 11, 15]"';
    is sort(mad([1, 5, 3, 8])), [[1, 3], [3, 5]], 'works for "[1, 5, 3, 8]"';
}

#| Take user provided numbers like 1 2 3 4
multi sub MAIN(*@ints) {
    say mad(@ints);
}
