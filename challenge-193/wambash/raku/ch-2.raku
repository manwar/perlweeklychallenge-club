#!/usr/bin/env raku

sub difference-array ($s) {
    $s
    andthen .comb
    andthen .map: &ord
    andthen .cache
    andthen .skip Z- $_
    andthen .Capture
}

sub odd-string (+@s) {
    @s
    andthen .classify: &difference-array
    andthen .values
    andthen .grep: *.elems == 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is difference-array('wzy'), \(3,-1);
    is odd-string(<adc wzy abc>),'abc';
    is odd-string('aaa', 'bob', 'ccc', 'ddd'), 'bob';
    done-testing;
}

multi MAIN (*@s) {
    put odd-string @s
}
