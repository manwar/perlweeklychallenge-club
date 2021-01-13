#!/usr/bin/env raku

# raku challenge-081/gugod/raku/ch-1.raku abcdabcd abcdabcdabcdabcd
# (abcd abcdabcd)

sub MAIN (Str $A, Str $B) {
    say common-base-string($A, $B);
}

sub common-base-string (Str $A, Str $B) {
    return ( base-string($A) ∩ base-string($B) ).keys;
}

sub base-string (Str $s) {
    return (1..$s.chars).grep(
        -> $n {
            ($s.chars mod $n == 0)
            && ($s.substr(0,$n) x ($s.chars div $n)) eq $s
        }).map(-> $n { $s.substr(0,$n) });
}
