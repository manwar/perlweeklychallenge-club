#!/usr/bin/env raku

sub bitwise-or (+ints) {
    ints
    andthen .grep: * %% 2
    andthen .head: 2
    andthen .elems == 2
}

multi MAIN (Bool :test($)!) {
    use Test;
    is bitwise-or(1,2,3,4,5), True;
    is bitwise-or(2,3,8,16),  True;
    is bitwise-or(1,3 ... 9), False;
    is bitwise-or(1...10¹⁹),  True;
    done-testing;
}

multi MAIN (+ints) {
    say bitwise-or +ints
}
