#!/usr/bin/env raku

sub count-words (+words, :$prefix) {
    words
    andthen .grep: *.starts-with: $prefix
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-words("pay", "attention", "practice", "attend"):prefix<at>,2;
    is count-words("janet", "julia", "java", "javascript"):prefix<ja>,3;
    done-testing;
}

multi MAIN (+words, :$prefix) {
    say count-words words, :$prefix
}
