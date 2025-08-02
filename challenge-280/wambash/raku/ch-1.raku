#!/usr/bin/env raku

sub twice-appearance ($str) {
    $str
    andthen .comb
    andthen .repeated
    andthen .head
}

multi MAIN (Bool :test($)!) {
    use Test;
    is twice-appearance('abcddbca'),'d';
    is twice-appearance('abccd'),'c';
    is twice-appearance('abcdabbb'),'a';
    done-testing;
}

multi MAIN ($str) {
    say twice-appearance $str
}
