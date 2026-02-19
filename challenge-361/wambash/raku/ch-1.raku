#!/usr/bin/env raku
constant FIB = (0 , 1, * + * ... *).cache;

sub zr-next ($int) {
    FIB.toggle: * ≤ $int
    andthen $int - .tail
}

sub zeckendorf-representation ($int) {
    $int, &zr-next ... 0
    andthen .rotor: 2 => -1
    andthen .map: { .head - .tail }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is zeckendorf-representation(4), (3,1), '4 = 3 + 1';
    is zeckendorf-representation(12), (8,3,1), '12 = 8 + 3 + 1';
    is zeckendorf-representation(20), (13,5,2), '20 = 13 + 5 + 2';
    is zeckendorf-representation(96), (89,5,2), '96 = 89 + 5 + 2';
    is zeckendorf-representation(100), (89,8,3), '100 = 89 + 8 + 3';
    done-testing;
}

multi MAIN ($int) {
    put zeckendorf-representation $int;
}
