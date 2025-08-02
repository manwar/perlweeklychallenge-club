#!/usr/bin/env raku
enum Col (<a>..<h>);

sub check-color ($coordinates) {
    $coordinates
    andthen .comb
    andthen Col::{.[0]} + .[1]
    andthen $_ %% 2
}

multi MAIN (Bool :test($)!) {
    use Test;
    is check-color('d3'), True;
    is check-color('g5'), False;
    is check-color('e6'), True;
    done-testing;
}

multi MAIN ($coordinates) {
    say check-color $coordinates
}
