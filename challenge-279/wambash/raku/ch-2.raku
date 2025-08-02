#!/usr/bin/env raku

sub split-string ($str) {
    $str
    andthen .comb: /:i <[aeiou]>/
    andthen .elems
    andthen $_ %% 2
}

multi MAIN (Bool :test($)!) {
    use Test;
    is split-string('perl'), False;
    is split-string('book'), True;
    is split-string('good morning'), True;
    is split-string('Ook'), True;
    done-testing;
}

multi MAIN ($str) {
    say split-string $str
}
