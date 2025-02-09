#!/usr/bin/env raku

sub find-anagrams (+words) {
    words
    andthen .map: *.comb.Bag
    andthen .unique
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is find-anagrams(<acca dog god perl repl>), 3;
    is find-anagrams(<abba baba aabb ab ab>), 2;
    done-testing;
}

multi MAIN (+words) {
    say find-anagrams words
}
