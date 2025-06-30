#!/usr/bin/env raku

sub missing-integers (+@ints) {
    1..+@ints
    andthen .grep: { $_ ∉ @ints }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is missing-integers(1,2,1,3,2,5), (4,6);
    is missing-integers(1 xx 3), (2,3);
    is missing-integers(2,1,1), (3,);
    done-testing;
}

multi MAIN (+ints) {
    put missing-integers ints».Int;
}
