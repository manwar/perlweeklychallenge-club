#!/usr/bin/env raku

sub binary-search-tree (*@t) {
    [before] @t
}

multi MAIN (Bool :test($)!) {
    use Test;
    is binary-search-tree((4,5,6),8,9), True;
    is binary-search-tree((3,4,6),5,7), False;
    is binary-search-tree(('A','B',('C','D','E')),'F','G'), True;
    done-testing;
}
