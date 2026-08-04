#!/bin/env raku

unit sub MAIN(Str:D $binary);

put (^$binary.chars).combinations(2).map({
    with $binary.substr(.[0], .[1]-.[0]+1) -> $s {
        my $len = $s.chars div 2;
        $s if $s.match(/^ (.) $0 ** {$len-1} <{1-$0}> ** {$len} $/)
    }
}).unique;
