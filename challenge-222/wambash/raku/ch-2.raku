#!/usr/bin/env raku

sub last-member-iter (@ints) {
    @ints
    andthen .sort
    andthen .reverse
    andthen .[0] - .[1], |.skip(2)
}

sub last-member (+@ints) {
    @ints, &last-member-iter ... *.elems == 1
    andthen .tail
}

multi MAIN (Bool :test($)!) {
    use Test;
    is last-member(2,7,4,1,8,1),1;
    is last-member(1),1;
    is last-member(1,1),0;
    is last-member(9,2,5),2;
    done-testing;
}

multi MAIN (*@ints) {
    put last-member @ints
}
