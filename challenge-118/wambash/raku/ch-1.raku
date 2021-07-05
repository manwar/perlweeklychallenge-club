#!/usr/bin/env raku

sub binary-palindorm ($n) {
    $n
    andthen .fmt: "%b"
    andthen $_ eq .flip
}

multi MAIN ($n) {
    say +so binary-palindorm $n
}

multi MAIN (Bool :test($)! ) {
    use Test;
    is binary-palindorm(4), False;
    is binary-palindorm(5), True;
    is binary-palindorm(2¹⁶-1), True;
    is binary-palindorm(2¹⁶  ), False;
    is binary-palindorm(2¹⁶+1), True;
    done-testing;
}
