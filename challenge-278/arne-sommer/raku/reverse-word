#! /usr/bin/env raku

unit sub MAIN ($word is copy, $char where $char.chars == 1);

$word = $0.comb.sort.join ~ $1 if $word ~~ /(.*? $char) (.*)/;

say $word;
