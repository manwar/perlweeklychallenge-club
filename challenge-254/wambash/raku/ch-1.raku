#!/usr/bin/env raku

sub three-power (UInt $n) {
    1,3,9 ... $n
    andthen .tail // -1
    andthen $_ == $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is three-power(27), True;
    is three-power( 1), True;
    is three-power( 0), False;
    is three-power(12), False;
    is three-power(3⁵⁶), True;
    is three-power(3⁵⁶+1), False;
    is three-power(3⁵⁶-3), False;
    done-testing;
}

multi MAIN (UInt $n) {
    say three-power $n
}
