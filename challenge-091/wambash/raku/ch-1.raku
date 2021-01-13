#!/usr/bin/env raku

sub count-numbers (UInt $n) {
    $n
    andthen m:g/$<num>=[\d] $<num>*/
    andthen .map: {.chars ~ .<num>}\
    andthen .join
}

multi MAIN (UInt $n ) {
    say count-numbers $n
}

multi MAIN (Bool :$test!) {
    use Test;
    is count-numbers(1122234), 21321314;
    is count-numbers(2333445), 12332415;
    is count-numbers(12345)  , 1112131415;
    done-testing;
}
