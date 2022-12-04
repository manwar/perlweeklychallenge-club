#!/usr/bin/env raku

sub binary-string ($n) {
    [X~] ^2 xx $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is binary-string(2), <00 01 10 11>;
    is binary-string(3), <000 001 010 011 100 101 110 111>;
    done-testing;
}

multi MAIN ($n) {
    .put for binary-string $n
}
