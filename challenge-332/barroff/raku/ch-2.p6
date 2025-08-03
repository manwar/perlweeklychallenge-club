#!/usr/bin/env raku

use v6.d;

sub odd-leters(Str $str --> Bool) {
    so map({ $_ mod 2 }, $str.comb.Bag.values).all == 1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is odd-leters("weekly"), False, 'works for "weekly"';
    is odd-leters("perl"), True, 'works for "perl"';
    is odd-leters("challenge"), False, 'works for "challenge"';
}

#| Take user provided string like "perl"
multi sub MAIN(Str $str) {
    say odd-leters($str);
}
