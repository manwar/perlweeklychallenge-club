#!/usr/bin/env raku

sub palindrom-number ( $n ) {
    $n eq $n.flip
}

multi MAIN (Bool :$test!) {
    use Test;
    is palindrom-number(1221), True;
    is palindrom-number(-101), False;
    is palindrom-number(  90), False;
    done-testing;
}

multi MAIN ($n) {
    say +palindrom-number $n
}
