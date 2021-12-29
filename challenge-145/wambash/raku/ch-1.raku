#!/usr/bin/env raku

sub dot-product (@a,@b) {
    @a Z* @b
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is dot-product((1,2,3),(4,5,6)), 32;
    done-testing;
}

multi MAIN (:@a,:@b) {
    say dot-product @a,@b
}
