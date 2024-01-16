#!/bin/env raku

unit sub MAIN(*@ints);

@ints = (+«@ints).sort;
if +@ints %% 2 and @ints.rotor(2).map({ .[0] == .[1] }).all {
    put @ints.rotor(2).map({ "({.[0]}, {.[1]})" }).join(', ');
} else {
    put '()';
}
