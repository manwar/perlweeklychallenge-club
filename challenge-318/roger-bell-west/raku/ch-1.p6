#! /usr/bin/raku

use Test;

plan 3;

is-deeply(groupposition('abccccd'), ['cccc'], 'example 1');
is-deeply(groupposition('aaabcddddeefff'), ['aaa', 'dddd', 'fff'], 'example 2');
is-deeply(groupposition('abcdd'), [], 'example 3');

sub groupposition($a) {
    my @mx;
    my $lc = 'z';
    for $a.comb.kv -> $i, $c {
        if ($i == 0) {
            $lc = ($c.ord + 1).chr;
        }
        if ($lc eq $c) {
            my $mc = @mx.elems;
            @mx[$mc - 1][1] += 1;
        } else {
            @mx.push([$c, 1]);
            $lc = $c;
        }
    }
    my @out;
    for @mx -> @ms {
        if (@ms[1] >= 3) {
            @out.push(@ms[0] x @ms[1]);
        }
    }
    @out;
}
