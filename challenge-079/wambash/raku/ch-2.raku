#!/usr/bin/env raku

sub trapped-rain-water ( +@n ) {
    @n.pairs
    andthen .map: { (@n[0.. .key].max min @n[.key..*].max) - .value }\
    andthen .sum
}

multi MAIN (:$test!) {
    use Test;
    is trapped-rain-water(2, 1, 4, 1, 2, 5),6;
    is trapped-rain-water(3, 1, 3, 1, 1, 5),6;
    done-testing;
}
