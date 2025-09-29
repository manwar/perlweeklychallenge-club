#!/bin/env raku

unit sub MAIN(Str:D $snt, *@keys);

put +$snt.lc.words.grep(!*.contains(@keys.any)); 
