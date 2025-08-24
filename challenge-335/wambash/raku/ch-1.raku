#!/usr/bin/env raku

sub common-charakters (+words) {
    words
    andthen .map: *.comb.Bag
    andthen [∩] $_
    andthen .kxxv
    andthen .sort
}

multi MAIN (Bool :test($)!) {
    use Test;
    is common-charakters(<bella label roller>), <e l l>;
    is common-charakters(<cool lock cook>), <c o>;
    is common-charakters('hello', 'world', 'pole'), <l o>;
    is common-charakters('abc', 'def', 'ghi'), Empty;
    is common-charakters('aab', 'aac', 'aaa'), <a a>;
    done-testing;
}

multi MAIN (+words) {
    put common-charakters words;
}
