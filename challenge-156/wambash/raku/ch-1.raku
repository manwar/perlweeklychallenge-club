#!/usr/bin/env raku

sub pernicious-numbers ($n=10) {
    ^∞
    andthen .grep: *.base(2).comb.sum.is-prime
    andthen .head($n)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is pernicious-numbers(10), <3 5 6 7 9 10 11 12 13 14>;
    done-testing;
}

multi MAIN ($n=10) {
    put pernicious-numbers $n
}
