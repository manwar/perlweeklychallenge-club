#!/usr/bin/env raku

sub count-equal-divisible (+ints,:$k) {
    ints
    andthen .pairs
    andthen .classify: *.value, as => *.key
    andthen .values
    andthen .map:  |*.combinations(2).map: -> (\x,\y) {x * y}\
    andthen .grep: { $_ %% $k }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-equal-divisible(3,1,2,2,2,1,3):2k,4;
    is count-equal-divisible(1,2,3):1k,0;
    done-testing;
}

multi MAIN (+ints,Int :$k) {
    say count-equal-divisible ints,:$k
}
