#!/usr/bin/env raku

sub unique-number (+ints) {
    ints
    andthen .Bag
    andthen .first: *.value == 1
    andthen .key
}

multi MAIN (Bool :test($)!) {
    use Test;
    is unique-number(3,3,1),1;
    is unique-number(3, 2, 4, 2, 4),3;
    is unique-number(1),1;
    is unique-number(4, 3, 1, 1, 1, 4),3;
    done-testing;
}

multi MAIN (+ints) {
    say unique-number ints
}
