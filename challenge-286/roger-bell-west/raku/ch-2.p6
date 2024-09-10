#! /usr/bin/raku

use Test;

plan 3;

is(ordergame([2, 1, 4, 5, 6, 3, 0, 2]), 1, 'example 1');
is(ordergame([0, 5, 3, 2]), 0, 'example 2');
is(ordergame([9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8]), 2, 'example 3');

sub ordergame(@a) {
    my @p = @a;
    while (@p.elems > 1) {
        my @q;
        my $mm = True;
        for @p.rotor(2 => -1) -> @j {
            if (@j.elems == 2) {
                if ($mm) {
                    @q.push(@j.min);
                } else {
                    @q.push(@j.max);
                }
                $mm = 1 - $mm;
            }
        }
        @p = @q;
    }
    return @p[0];
}
