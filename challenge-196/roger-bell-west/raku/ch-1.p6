#! /usr/bin/perl6

use Test;

plan 4;

is-deeply(pattern132([3, 1, 4, 2]), [1, 4, 2], 'example 1');
is-deeply(pattern132([1, 2, 3, 4]), [], 'example 2');
is-deeply(pattern132([1, 3, 2, 4, 6, 5]), [1, 3, 2], 'example 3');
is-deeply(pattern132([1, 3, 4, 2]), [1, 3, 2], 'example 4');

sub pattern132(@l) {
    my @o = [];
    OLOOP:
    for (0..@l.elems-3) -> $a {
        for ($a+1..@l.elems-2) -> $b {
            if (@l[$a] < @l[$b]) {
                for ($b+1..@l.elems-1) -> $c {
                    if (@l[$b] > @l[$c] && @l[$a] < @l[$c]) {
                        @o = [@l[$a], @l[$b], @l[$c]];
                        last OLOOP;
                    }
                }
            }
        }
    }
    return @o;
}
