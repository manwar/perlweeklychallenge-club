#!/usr/bin/env raku

sub MAC-address ($address) {
    $address
    andthen .match: /\w**2/, :g
    andthen .fmt: '%2s', ':'
}

multi MAIN (Bool :test($)!) {
    use Test;
    plan 2;
    is MAC-address('1ac2.34f0.b1c2'), '1a:c2:34:f0:b1:c2';
    is MAC-address('abc1.20f1.345a'), 'ab:c1:20:f1:34:5a';
}

multi MAIN ($address) {
    say MAC-address $address
}
