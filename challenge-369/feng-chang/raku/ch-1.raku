#!/bin/env raku

unit sub MAIN(Str:D $str);

my @words = $str.words;
put ('#' ~ (@words[0].lc ~ @words[1..*].map(*.tc).join).subst(/<-[a..zA..Z]>/, '', :g)).substr(0, 100);
