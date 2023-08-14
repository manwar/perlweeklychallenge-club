#! /usr/bin/raku

use Test;

plan 2;

is(lexicographic(['abc', 'bce', 'cae']), 1, 'example 1');
is(lexicographic(['yxz', 'cba', 'mon']), 2, 'example 2');

sub lexicographic(@a) {
    my $t = 0;
    for @a -> $st {
        my @q = $st.comb.sort;
        if (join('', @q) eq $st) {
            next;
        }
        @q = reverse @q;
        if (join('', @q) eq $st) {
            next;
        }
        $t++;
    }
    return $t;
}
