#!/bin/env raku

unit sub MAIN(Str:D $sentence);

put $sentence.words.sort(*.lc).join(' ');
