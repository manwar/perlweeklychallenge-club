#!/usr/bin/env raku

sub smaller-than-current (+@ints) {
    my %small := (
    @ints
    andthen .sort
    andthen .squish
    andthen .antipairs
    andthen .Map
    );

    @ints.map: -> \i { %small{i} }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is smaller-than-current(5,2,1,6),(2,1,0,3);
    is smaller-than-current(1,2,0,3),(1,2,0,3);
    is smaller-than-current(0,1),(0,1);
    is smaller-than-current(9,4,9,2),(2,1,2,0);
    done-testing;
}


multi MAIN (*@ints) {
    put smaller-than-current @ints
}
