#!/usr/bin/env raku

sub duplicate-zeros (+@ints) {
    @ints
    andthen .map: { $_ == 0 ?? |(0,0)  !! $_ }\
    andthen .head: @ints.elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is duplicate-zeros(1,0,2,3,0,4,5,0), (1,0,0,2,3,0,0,4);
    is duplicate-zeros(1,2,3), (1,2,3);
    is duplicate-zeros(0,3,0,4,5), (0,0,3,0,0);
    done-testing;
}

multi MAIN (*@ints) {
    put duplicate-zeros @ints
}
