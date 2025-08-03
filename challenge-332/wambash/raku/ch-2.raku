#!/usr/bin/env raku

sub odd-letters ($str) {
    $str
    andthen .comb
    andthen .Bag
    andthen .values
    andthen so .none %% 2
}

multi MAIN (Bool :test($)!) {
    use Test;
    is odd-letters('weekly'), False;
    is odd-letters('perl'), True;
    is odd-letters('challenge'), False;
    done-testing;
}

multi MAIN ($str) {
    say odd-letters $str;
}
