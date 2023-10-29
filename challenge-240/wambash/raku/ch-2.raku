#!/usr/bin/env raku

sub build-array (+@int) {
    @int[@int]
}

multi MAIN (Bool :test($)!) {
    use Test;
    is build-array(0,2,1,5,3,4),(0,1,2,4,5,3);
    is build-array(5,0,1,2,3,4),(4,5,0,1,2,3);
    done-testing;
}

multi MAIN (*@int) {
    say build-array @int
}
