#!/bin/env raku

unit sub MAIN(Str:D $s);

put (^$s.chars).combinations(2).map({ with $s.substr(.[0], .[1]-.[0]+1) { $_ if is-nice($_) } }).sort(*.chars).tail || '';

sub is-nice(Str:D $s --> Bool:D) {
    so $s.comb.map({ $s.contains(chr(.lc.ord + .uc.ord - .ord)) }).all
}
