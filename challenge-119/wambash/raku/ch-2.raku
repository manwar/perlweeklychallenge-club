#!/usr/bin/env raku

sub sequence-without-iter (+@n) {
    @n
    andthen 1,2,3 X~ $_
    andthen .grep: {!/11/}
}

constant @sequence-without = ((1,2,3), { sequence-without-iter(|$_).cache } ... *).flat;
multi MAIN (Bool :test($)!) {
    use Test;
    is sequence-without-iter(''), <1 2 3>;
    is sequence-without-iter(1,2,3), <12 13 21 22 23 31 32 33>;
    is @sequence-without.head(15), (1, 2, 3, 12, 13, 21, 22, 23, 31, 32, 33, 121, 122, 123, 131);
    done-testing;
}
