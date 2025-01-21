#!/bin/env raku

unit sub MAIN(*@words);

my @alien-dict = @words.pop.comb;
put @words.sort({ .trans('a'..'z' => @alien-dict) });
