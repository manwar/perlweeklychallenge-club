#!/usr/bin/env raku

sub unequal-triplets (+ints) {
    ints
    andthen .Bag
    andthen .values
    andthen .combinations: 3
    andthen .map: { [*] $_ }\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is unequal-triplets(4,4,2,4,3),3;
    is unequal-triplets(1,1,1,1,1),0;
    is unequal-triplets(4, 7, 1, 10, 7, 4, 1, 1), 28;
    done-testing;
}

multi MAIN (+@ints) {
    say unequal-triplets @ints
}
