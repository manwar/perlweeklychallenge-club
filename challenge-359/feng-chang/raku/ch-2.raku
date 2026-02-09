#!/bin/env raku

unit sub MAIN(Str:D $word is copy);

$word .= subst(/(.)$0+/, '', :g) while $word.match(/(.)$0+/);
put $word;
