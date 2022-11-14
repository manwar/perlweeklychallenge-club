#!/usr/bin/env raku

multi decode(Int(Str) $coded-char) {
    chr $coded-char + 'A'.ord - 1
}

multi decode(+@coded-str) {
    @coded-str
    andthen .map: &decode
    andthen .join
}

sub decoded-list (Int(Str) $s) {
    $s
    andthen m:ex{ ^(\d|\d**2 <?{$/ <= 26}>)+$ } #>
    andthen .map: *.[0]>>.Int
    andthen .map: &decode
    andthen .reverse
}

multi MAIN (Bool :test($)!) {
    use Test;
    is decode(1),'A';
    is decode(26),'Z';
    is decode(1,7,15,26), 'AGOZ';
    is decoded-list(11), ('AA','K');
    is decoded-list(1115), <AAAE AAO AKE KAE KO>;
    is decoded-list(127), ('ABG','LG');
    done-testing;
}

multi MAIN (Int $s) {
    put decoded-list  $s
}
