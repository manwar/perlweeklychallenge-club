#!/bin/env raku

unit sub MAIN(*@words);

my $regs = @words.pop.lc.comb.grep(/<[a..z]>/).Set;
put @words.grep({ .comb.Set (>=) $regs }).map({ "'$_'" }).join(', ');
