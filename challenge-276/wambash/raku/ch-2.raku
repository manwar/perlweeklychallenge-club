#!/usr/bin/env raku

sub maximum-frequency (+ints) {
    ints
    andthen .Bag
    andthen .max: :with( *.value ), :v
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is maximum-frequency(1,2,2,4,1,5),4;
    is maximum-frequency(1,2,3,4,5),5;
    done-testing;
}

multi MAIN (+ints) {
    say maximum-frequency ints
}
