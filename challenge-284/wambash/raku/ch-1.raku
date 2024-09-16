#!/usr/bin/env raku

sub lucky-integers (+ints) {
    ints
    andthen .Bag
    andthen .grep: { .key == .value }\
    andthen .max
    andthen .?key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is lucky-integers(2,2,3,4),2;
    is lucky-integers(1, 2, 2, 3, 3, 3),3;
    is lucky-integers(1, 1, 1, 3),Nil;
    done-testing;
}

multi MAIN (+ints) {
    say lucky-integers(ints) // -1
}
