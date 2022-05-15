#!/usr/bin/env raku

constant odd-palindrome = ^10,  { .flat.map( {  ^10 »~» $_ »~« ^10  } ).cache } ... *;
subset Even where * %% 2;

proto prime-palindrom (UInt $n=3) {*}
multi prime-palindrom (2) { 11, }
multi prime-palindrom (Even $n) { () }
multi prime-palindrom ($n=3) {
    odd-palindrome[($n-1) div 2]
    andthen .flat.grep: *.is-prime
}

multi MAIN (Bool :test($)!) {
    use Test;
    is prime-palindrom(1), (2,3,5,7);
    is prime-palindrom(2), 11;
    is prime-palindrom().sort, (101, 131, 151, 181, 191, 313, 353, 373, 383, 727, 757, 787, 797, 919, 929,);
    is prime-palindrom(8), ();
    done-testing;
}

multi MAIN ($n=3) {
    put (1..$n).map: &prime-palindrom
}
