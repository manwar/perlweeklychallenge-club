#!/usr/bin/env raku

sub maximum-xor (+@list) {
    @list
    andthen .combinations: 2
    andthen .map: -> (\x,\y) {x +^ y}\
    andthen .max
}

multi MAIN (Bool :test($)!) {
    use Test;
    is maximum-xor(1..7),7;
    is maximum-xor(2,4,1,3),7;
    is maximum-xor(10,5,7,12,8),15;
    done-testing;
}

multi MAIN (*@list) {
    say maximum-xor @list
}
