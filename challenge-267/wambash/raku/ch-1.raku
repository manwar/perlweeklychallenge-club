#!/usr/bin/env raku

sub product-sign (+ints) {
    ints
    andthen .map: *.sign
    andthen [*] $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    is product-sign(-1, -2, -3, -4, 3, 2, 1), 1;
    is product-sign(1, 2, 0, -2, -1), 0;
    is product-sign(-1, -1, 1, -1, 2), -1;
    done-testing;
}

multi MAIN (+ints) {
    say product-sign ints
}
