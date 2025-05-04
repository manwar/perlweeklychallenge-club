#!/usr/bin/env raku
use v6.e.*;

sub minimum-common (+arrays) {
    arrays
    andthen [∩] $_
    andthen .keys
    andthen .min

}

multi MAIN (Bool :test($)!) {
    use Test;
    is minimum-common((1,2,3,4),(3,4,5,6)), 3;
    is minimum-common((1,2,3),(2,4)), 2;
    is minimum-common((1,2,3,4),(5,6,7,8)), Inf;
    done-testing;
}

    multi MAIN (+arrays) {
        say do with minimum-common arrays».comb: /\d+/ {
            when Inf {-1}
            default  {$_}
        }
}
