#!/bin/env raku

unit sub MAIN();

my (@M, $line-num);

for $*IN.lines -> $line {
    last unless $line;
    @M[$line-num++] = (+«$line.words).map(1-*).reverse.Array;
}
put @M.gist;
