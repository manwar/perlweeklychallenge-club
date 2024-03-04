#!/bin/env raku

unit sub MAIN(Str:D $langs, Str:D $popular);

my %langs = $langs.words Z=> +«$popular.words;
put %langs.keys.sort({ %langs{$_} });
