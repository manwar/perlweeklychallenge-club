#!/usr/bin/env raku

sub unique-occurences (+ints) {
    ints
    andthen .Bag
    andthen .values
    andthen .repeated
    andthen .not
}

multi MAIN (Bool :test($)!) {
    use Test;
    is unique-occurences(1,2,2,1,1,3),True;
    is unique-occurences(1,2,3),False;
    is unique-occurences(-2,0,1,-2,1,1,0,1,-2,9),True;
    done-testing;
}

multi MAIN (+ints) {
    say +unique-occurences ints
}
