#!/usr/bin/env raku
use Prime::Factor;

sub is-Achilles ($n) {
    prime-factors $n
    andthen bag $_
    andthen .values.cache
    andthen (.all > 1) & (1 == [gcd] $_)
    andthen .so
}

constant Achilles = (2..∞).grep: &is-Achilles;
multi MAIN (Bool :test($)!) {
    use Test;
    is is-Achilles(72),True;
    is is-Achilles(36),False;
    is is-Achilles(1568),True;
    is is-Achilles(1668),False;
    is Achilles.head(20),(72, 108,  200,  288,  392,  432,  500,  648,  675,  800,  864, 968, 972, 1125, 1152, 1323, 1352, 1372, 1568, 1800);
    done-testing;
}

multi MAIN (UInt $n=20) {
    put Achilles.head: $n
}
