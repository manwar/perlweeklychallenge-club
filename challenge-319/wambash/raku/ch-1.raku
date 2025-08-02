#!/usr/bin/env raku

sub word-count (+list) {
    list
    andthen .grep: *.contains: / ^<[aeiou]> | <[aeiou]>$ /
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is word-count(<uncode xml raku perl>),2;
    is word-count(<the weekly challenge>),2;
    is word-count(<perl python postgres>),0;
    done-testing;
}

multi MAIN (+list) {
    say word-count list
}
