#!/usr/bin/env raku

sub rank-array (+ints) {
    my %ranks := %( ints.sort.squish.antipairs );

    ints.map: { %ranks{$_} + 1 }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is rank-array(55,22,44,33), (4,1,3,2);
    is rank-array(10,10,10), (1,1,1);
    is rank-array(5,1,1,4,3), (4,1,1,3,2);
    done-testing;
}

multi MAIN (+ints) {
    put rank-array ints;
}
