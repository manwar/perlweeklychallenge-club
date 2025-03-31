#!/bin/env raku

unit sub MAIN(*@words where @words[*-1].chars == 1);

my $c = @words.pop;
put (^+@words).grep({ @words[$_].contains($c) });
