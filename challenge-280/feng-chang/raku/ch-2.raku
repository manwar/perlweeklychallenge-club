#!/bin/env raku

unit sub MAIN(Str:D $s);

put +$s.split('|')[0,2...*].join.comb.grep('*');
