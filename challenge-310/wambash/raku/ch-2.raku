#!/usr/bin/env raku
use v6.e.PREVIEW;

sub sort-odd-even (+ints) {
    roundrobin ints.skip(1 xx *).sort, ints.skip(0,1 xx *).sort.reverse, :slip
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sort-odd-even(4, 1, 2, 3), (2,3,4,1);
    is sort-odd-even(3,1), (3,1);
    is sort-odd-even(5,3,2,1,4), (2,3,4,1,5);
    done-testing;
}

multi MAIN (+ints) {
    put sort-odd-even ints
}
