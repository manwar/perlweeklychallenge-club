#!/usr/bin/env raku

enum Alphabet (<a>..<z>);

sub minimum-time ($str) {
    $str
    andthen .comb
    andthen 0,|.map: {Alphabet::{$_}}\
    andthen .rotor: 2 => -1
    andthen .map: -> ($a,$b) {
        abs $b - $a
        andthen $_ min +Alphabet:: - $_
    }\
    andthen .sum + $str.chars
}

multi MAIN (Bool :test($)!) {
    use Test;
    is minimum-time('abc'),5;
    is minimum-time('bza'),7;
    is minimum-time('zjpc'),34;
    done-testing;
}

multi MAIN ($str) {
    say minimum-time $str
}
