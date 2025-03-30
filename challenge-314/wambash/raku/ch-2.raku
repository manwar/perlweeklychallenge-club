#!/usr/bin/env raku

sub sort-column (+list) {
    list
    andthen .map: *.comb
    andthen [Zle] $_
    andthen .map: *.not
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sort-column(<swpc tyad azbe>),2;
    is sort-column(<cba daf ghi>),1;
    is sort-column(<a b c>),0;
    done-testing;
}

multi MAIN (+list) {
    say sort-column list
}
