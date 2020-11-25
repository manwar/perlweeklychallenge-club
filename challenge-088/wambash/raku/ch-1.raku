#!/usr/bin/env raku

sub array-of-product (+@n) {
    @n
    andthen .keys
    andthen .map: { [*]  @n[ 0 ..^ $_, $_ ^.. * ].flat }
}

multi MAIN (+@n) {
    say array-of-product @n
}

multi MAIN (Bool :$test!) {
    use Test;
    is array-of-product(5, 2, 1, 4, 3), (24, 60, 120, 30, 40);
    is array-of-product(2, 1, 4, 3),    (12, 24, 6, 8);
}
