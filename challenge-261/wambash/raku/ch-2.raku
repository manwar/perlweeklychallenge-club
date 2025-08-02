#!/usr/bin/env raku

sub multiply-by-two (+ints,:$start) {
    $start, * * 2 ... *
    andthen .first: { $_ ∉ ints }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is multiply-by-two(5,3,6,1,12):3start, 24;
    is multiply-by-two(1,2,4,3):1start, 8;
    is multiply-by-two(1,2,4,8,16):1start, 32;
    is multiply-by-two(5,6,7):2start, 2;
    done-testing;
}

multi MAIN ( +ints,Int :$start) {
    say multiply-by-two ints».Int,:start($start.Int)
}
