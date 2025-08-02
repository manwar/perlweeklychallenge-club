#!/bin/env raku

unit sub MAIN(*@words);

my $chk = @words.pop;
put $chk.lc eq @words.map(*.substr(0,1)).join.lc;
