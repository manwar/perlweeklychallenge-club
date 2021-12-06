#!/usr/bin/env raku

sub line-numbers ($m, $n) {
    $m
    andthen .comb
    andthen .combinations: 1 ..^ $m.chars
    andthen .map: *.join
    andthen .grep: { $_ %% $n }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is +line-numbers( 1234, 2 ), 9;
    is +line-numbers(  768, 4 ), 3;
    is  line-numbers(  768, 4 ), <8 76 68>;
    is  line-numbers( 1234, 2 ), <2 4 12 14 24 34 124 134 234>;
    done-testing;
}

multi MAIN ($m, $n) {
    say +line-numbers $m, $n
}
