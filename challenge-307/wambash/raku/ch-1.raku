#!/usr/bin/env raku

sub check-order (+@ints) {
    @ints Z== @ints.sort
    andthen .grep: *.not, :k
}

multi MAIN (Bool :test($)!) {
    use Test;
    is check-order(5,2,4,3,1),(0,2,3,4);
    is check-order(1, 2, 1, 1, 3), (1,3);
    is check-order(3, 1, 3, 2, 3), (0,1,3);
    done-testing;
}

multi MAIN (+ints) {
    put check-order ints
}
