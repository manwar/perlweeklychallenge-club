#!/usr/bin/env raku

sub last-word ($str) {
    $str
    andthen .words
    andthen .tail
    andthen .chars
}

multi MAIN (Bool :test($)!) {
    use Test;
    is last-word('The Weekly Challenge'), 9;
    is last-word('   Hello   World    '), 5;
    is last-word('Let\'s begin the fun' ), 3;
    done-testing;
}

multi MAIN ($str) {
    say last-word $str;
}
