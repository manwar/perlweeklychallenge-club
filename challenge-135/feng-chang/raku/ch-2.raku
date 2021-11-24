#!/bin/env raku

my method digit-value(Str:D $d where *.chars == 1 :) {
    return $d.Int           if '0' le $d le '9';
    return $d.ord - 'A'.ord if 'A' le $d le 'Z';
    die 'wrong digit: ', $d;
}

sub check-digit(Str:D $sedol where *.chars == 6 --> UInt:D) {
    state @weights = 1, 3, 1, 7, 3, 9, 1;
    my @digits = $sedol.comb;

    10 - (^6)».&{ @digits[$_].&digit-value * @weights[$_] }.sum % 10
}

sub MAIN(Str:D $S where *.chars == 7) {
    my Str $s = uc($S);
    put +so check-digit($s.substr(0, 6)) == $s.substr(6, 1).Int;
}
