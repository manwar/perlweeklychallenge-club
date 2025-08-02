#!/bin/env raku

unit sub MAIN(Str:D $s);

put $s.match(/(.).*$0/, :ex).sort(*.pos)[0].comb[0];
