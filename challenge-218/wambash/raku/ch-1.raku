#!/usr/bin/env raku

sub maximum-product (+@list) {
    @list
    andthen .sort.cache
    andthen ([*] .tail(3)) max ([*] |.head(2), .tail)
}

multi MAIN (Bool :test($)!) {
    use Test;
    is maximum-product(3, 1, 2),6;
    is maximum-product(4, 1, 3, 2),24;
    is maximum-product(-1, 0, 1, 3, 1),3;
    is maximum-product(-8, 2, -9, 0, -4, 3), 216;
    done-testing;
}

multi MAIN (*@list) {
    say maximum-product @list
}
