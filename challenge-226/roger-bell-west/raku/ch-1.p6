#! /usr/bin/raku

use Test;

plan 2;

is(shufflestring('lacelengh', [3, 2, 0, 5, 4, 8, 6, 7, 1]), 'challenge', 'example 1');
is(shufflestring('rulepark', [4, 7, 3, 1, 0, 5, 2, 6]), 'perlraku', 'example 2');

sub shufflestring($st, @mp) {
    my @q = $st.comb;
    my @r = ' ' xx @q.elems;
    for 0 .. @mp.end -> $i {
        @r[@mp[$i]] = @q[$i];
    }
    return @r.join('');
}
