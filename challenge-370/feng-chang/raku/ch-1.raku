#!/bin/env raku

unit sub MAIN(Str:D $str, *@banned);

my %words = $str.lc.comb(/<[a..z]>+/).Bag;
%words{@banned}:delete;
put %words.max(:k);
