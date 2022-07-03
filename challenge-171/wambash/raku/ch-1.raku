#!/usr/bin/env raku
use Prime::Factor;

sub sum-of-dividors (UInt $n) {
    [+] divisors $n
}

sub is-abudant (UInt $n) {
    sum-of-dividors($n) > 2*$n
}

constant @abudant-numbers = (^∞).grep: &is-abudant;

multi MAIN (Bool :test($)!) {
    use Test;
    is sum-of-dividors(12), 1+2+3+4+6+12;
    is is-abudant(12), True;
    is is-abudant(945), True;
    is is-abudant(8), False;
    is @abudant-numbers.head(28), (12, 18, 20, 24, 30, 36, 40, 42, 48, 54, 56, 60, 66, 70, 72, 78, 80, 84, 88, 90, 96, 100, 102, 104, 108, 112, 114, 120);
    done-testing;
}

multi MAIN (UInt $n=20) {
    @abudant-numbers
    andthen .head: $n
    andthen .Supply
    andthen .tap(&put)
}
