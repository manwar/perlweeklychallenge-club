#!/usr/bin/env raku

constant @square = ^Inf .map: *² ;

sub largest-square (:$base=10) {
    @square
    andthen .map: *.base: $base
    andthen .toggle: { .chars ≤ $base }\
    andthen .first: !*.comb.repeated, :end
}

multi MAIN (Bool :test($)!) {
    use Test;
    is largest-square(),9814072356;
    is largest-square(:2base), '1';
    is largest-square(:4base), '3201';
    is largest-square(:11base), 'A8701245369';
    skip 'base 12 -- Too slow (cca 35s)';
    #is largest-square(:12base), 'B8750A649321', 'base 12';
    done-testing;
}

multi MAIN ($base=10) {
    say largest-square :$base
}
