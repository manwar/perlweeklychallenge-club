#!/bin/env raku

unit sub MAIN(*@N);

sub is-square(UInt:D \S --> Bool:D) { sqrt(S).Int² == S }

@N = @N».Int;

put @N.permutations
    .grep(-> @M { (^(+@N-1)).map({ is-square(@M[$_] + @M[$_+1]) }).all })
    .unique(:with(&[eqv]))
    .map({ .join(', ') })
    .join("\n");
