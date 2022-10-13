#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.e = 'dictionary.txt');

my @a = $f.IO.words.grep({[!gt] .comb});
put @a.grep(*.comb.any eq 'z');
