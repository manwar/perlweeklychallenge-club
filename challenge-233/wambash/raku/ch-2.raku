#!/usr/bin/env raku

sub frequency-sort (+ints) {
    ints
    andthen .Bag
    andthen .sort: { .value, -.key }\
    andthen .map:  { slip .key xx .value }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply frequency-sort(1,1,2,2,2,3),(3,1,1,2,2,2);
    is-deeply frequency-sort(2,3,1,3,2),(1,3,3,2,2);
    is-deeply frequency-sort(-1,1,-6,4,5,-6,1,4,1),(5,-1,4,4,-6,-6,1,1,1);
    done-testing;
}

multi MAIN (+ints) {
    put frequency-sort ints
}
