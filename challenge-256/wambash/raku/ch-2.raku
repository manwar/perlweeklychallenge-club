#!/usr/bin/env raku

sub merge-strings (+string) {
    string
    andthen .map: *.comb
    andthen roundrobin |$_, :slip
    andthen .join
}

multi MAIN (Bool :test($)!) {
    use Test;
    is merge-strings(<abcd 1234>),    'a1b2c3d4';
    is merge-strings('abc','12345'),  'a1b2c345';
    is merge-strings(<abcde 123>),    'a1b2c3de';
    is merge-strings(<abcde 123 AB>), 'a1Ab2Bc3de';
    done-testing;
}

multi MAIN (+string) {
    say merge-strings string
}
