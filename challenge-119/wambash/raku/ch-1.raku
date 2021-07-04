#!/usr/bin/env raku

sub swap-nibbles ($n) {
    blob8.new($n)
    andthen .read-ubits(4,4)*16 + .read-ubits(0,4)
}

multi MAIN (Int $n ) {
    say swap-nibbles $n;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is swap-nibbles(101), 86;
    is swap-nibbles(18), 33;
    is swap-nibbles(255), 255;
    is swap-nibbles(17), 17;
    done-testing;
}
