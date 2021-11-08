#!/usr/bin/env raku

sub count-numbers (Int $n) {
    1..*
    andthen .map: *.base(9)
    andthen .map: *.trans: 1..8 => 2..9
    andthen .toggle: { $_ ≤ $n }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-numbers(15),  8;
    is count-numbers(25), 13;
    done-testing;
}

multi MAIN ($n) {
    say count-numbers $n
}
