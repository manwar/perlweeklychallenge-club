#!/usr/bin/env raku

use v6;

sub fact( UInt $n ) {
    [*] (1..$n);
}

#| Find the number of trailing zeros in N factorial
sub MAIN (
    UInt $N where * <= 10 #= Number to find factorial of (from 0 to 10)
) {
    say (fact($N) ~~ m!(0*)$!)[0].Str.codes;
}
