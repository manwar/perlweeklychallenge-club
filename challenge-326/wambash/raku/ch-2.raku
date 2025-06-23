#!/usr/bin/env raku

sub decompressed-list (+ints) {
    ints.map: -> $t, $n { slip $n xx $t }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply decompressed-list(1,3,2,4), (3,4,4);
    is-deeply decompressed-list(1,1,2,2), (1,2,2);
    is-deeply decompressed-list(3,1,3,2), (1,1,1,2,2,2);
    done-testing;
}

multi MAIN (+ints) {
    put decompressed-list ints;
}
