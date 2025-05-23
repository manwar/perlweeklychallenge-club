#!/usr/bin/env raku

sub distinct-average (+nums) {
    nums
    andthen .sort
    andthen .cache Z+ .reverse
    andthen .unique
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is distinct-average(^6), 1;
    is distinct-average(0,2,4,8,3,5), 2;
    is distinct-average(7,3,1,0,5,9), 2;
    done-testing;
}

multi MAIN (+nums) {
    say distinct-average nums;
}
