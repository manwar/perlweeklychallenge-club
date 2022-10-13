#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.e = 'dictionary.txt');

put $f.IO.words.grep({[!gt] .comb});
