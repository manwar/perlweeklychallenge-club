#!/usr/bin/env raku

sub gcd-sum (UInt $n) {
    1..$n
    andthen .combinations: 2
    andthen .map:  { [gcd] $_ }\
    andthen .sum
}

multi MAIN (UInt $n) {
    say gcd-sum $n;
}

multi MAIN (Bool :$test!) {
    use Test;
    is gcd-sum(3), 3;
    is gcd-sum(4), 7;
    done-testing;
}
