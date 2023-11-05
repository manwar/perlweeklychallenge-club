#!/usr/bin/env raku
use Prime::Factor;

sub prime-order (+int) {
    int.sort: {prime-factors($_).elems, +$_}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is prime-order(11,8,27,4),(11,4,8,27);
    is prime-order(9,11,8,27,4),(11,4,9,8,27);
    done-testing;
}

multi MAIN (+int) {
    put prime-order int
}
