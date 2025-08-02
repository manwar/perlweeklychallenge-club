#!/usr/bin/env raku

sub target-index (+ints,:$k) {
    ints
    andthen .sort
    andthen .grep: { $_ == $k },:k
}

multi MAIN (Bool :test($)!) {
    use Test;
    is target-index(1,5,3,2,4,2,:2k),(1,2);
    is target-index(1..5,:6k),();
    is target-index(5,3,2,4,2,1,:4k),(4);
    done-testing;
}

multi MAIN (+ints,:$k) {
    put target-index ints,:$k
}
