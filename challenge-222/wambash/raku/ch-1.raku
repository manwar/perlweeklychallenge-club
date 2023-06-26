#!/usr/bin/env raku

sub matching-members (+@ints) {
    @ints [Z==] @ints.sort
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is matching-members(1,1,4,2,1,3),3;
    is matching-members(5,1,2,3,4),  0;
    is matching-members(1,2,3,4,5),  5;
    done-testing;
}

multi MAIN (*@ints) {
    say matching-members @ints
}
