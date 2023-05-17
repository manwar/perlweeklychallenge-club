#! /usr/bin/raku

use Test;

plan 5;

is(maxnumber([1, 23]), 231, 'example 1');
is(maxnumber([10, 3, 2]), 3210, 'example 2');
is(maxnumber([31, 2, 4, 10]), 431210, 'example 3');
is(maxnumber([5, 11, 4, 1, 2]), 542111, 'example 4');
is(maxnumber([1, 10]), 110, 'example 5');

sub maxnumber(@lst) {
    my @po = @lst.map({Str($_)});
    my $pl = @po.map({chars($_)}).max;
    my @pm;
    for @po -> $so {
        my $sm = $so;
        my @q = $so.comb;
        if (@q.elems < $pl) {
            my $c = @q[*-1];
            $sm ~= $c x ($pl - @q.elems);
        }
        @pm.push($sm);
    }
    my $out = '';
    my @pi = (0..@pm.end);
    for @pi.sort({@pm[$^b] cmp @pm[$^a]}) -> $st {
        $out ~= @po[$st];
    }
    return 0 + $out;
}
