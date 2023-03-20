#!/bin/env raku

unit sub MAIN(*@words);

my %AtRow = <qwertyuiop asdfghjkl zxcvbnm>.map({ .comb.all => $++ });

put @words.grep({ [==] %AtRow{ .lc.comb } });
