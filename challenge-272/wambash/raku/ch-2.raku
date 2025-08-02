#!/usr/bin/env raku

sub string-score ($str) {
    $str
    andthen .ords
    andthen .rotor: 2 => -1
    andthen .map: -> ($x, $y) {abs $x - $y}\
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is string-score('hello'),13;
    is string-score('perl'), 30;
    is string-score('raku'), 37;
    done-testing;
}

multi MAIN ($str) {
    say string-score $str
}
