#!/usr/bin/env raku

sub hamming-distance (+@ints) {
    my $elems = @ints.elems;

    @ints
    andthen .map: { .polymod: 2 xx * }\
    andthen roundrobin $_
    andthen .map: *.sum
    andthen .map: { $_ * ($elems - $_) }\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is hamming-distance(4,14,2),6;
    is hamming-distance(4,14,4),4;
    subtest {
        is hamming-distance(^(2**$_)), $_ * 4**($_-1) for ^16;
    }
    done-testing;
}

multi MAIN (+@ints) {
    say hamming-distance @ints
}
