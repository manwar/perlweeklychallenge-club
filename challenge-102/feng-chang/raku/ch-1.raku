#!/bin/env raku

sub is-square(UInt:D \N --> Bool:D) {
    my UInt $n = N.sqrt.UInt;
    N == $n * $n;
}

sub MAIN(UInt:D \N) {
    my UInt $min = ('1' ~ '0' x N-1).UInt;
    my UInt $max = ('9' x N).UInt;
    for $min..$max -> $m {
        my UInt $n = $m.flip.UInt;
        next if $n > $m;

        put $m if is-square($m + $n) and is-square($m - $n);
    }
}
