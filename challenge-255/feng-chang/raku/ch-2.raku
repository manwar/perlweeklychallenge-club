#!/bin/env raku

unit sub MAIN(Str:D $snt, Str:D $banned);

my %words is BagHash = $snt.comb(/\w+/);
%words{$banned}:delete;
put %words.sort(-*.value).first.key;
