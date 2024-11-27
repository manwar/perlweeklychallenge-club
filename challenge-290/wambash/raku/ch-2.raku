#!/usr/bin/env raku

sub Luhns-algorithm ($str) {
    $str
    andthen .flip
    andthen .comb(/\d/)
    andthen $_ Z* |(1,2) xx *
    andthen .map: { |.comb }\
    andthen .sum
    andthen $_ %% 10
}

multi MAIN (Bool :test($)!) {
    use Test;
    is Luhns-algorithm(17893729974),True;
    is Luhns-algorithm('4137 8947 1175 5904'),True;
    is Luhns-algorithm('4137 8974 1175 5904'),False;
    done-testing;
}

multi MAIN ($str) {
    say Luhns-algorithm  $str
}
