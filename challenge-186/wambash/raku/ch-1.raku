#!/usr/bin/env raku

sub zip-list (+@lol) {
    [Z,] @lol
    andthen .map: *.Slip
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply zip-list(<1 2 3>,<a b c>),<1 a 2 b 3 c>;
    is-deeply zip-list(<a b c>,<1 2 3>),<a 1 b 2 c 3>;
    done-testing;
}

multi MAIN (*@lol) {
    @lol
    andthen .map: *.split: ','
    andthen .&zip-list
    andthen .put
}
