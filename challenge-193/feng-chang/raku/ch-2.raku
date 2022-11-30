#!/bin/env raku

unit sub MAIN(*@S);

my @diffs = @S».comb.map(-> @s { (1..^@S[0].chars).map({ @s[$_].ord - @s[$_-1].ord }).Array });
put @S[@diffs.grep(-> \df { (^+@S).grep({ df eqv @diffs[$_] }).elems == 1 }, :k)[0]];
