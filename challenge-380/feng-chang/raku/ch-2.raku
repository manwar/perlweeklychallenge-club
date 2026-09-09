#!/bin/env raku

unit sub MAIN(Str:D $str);

my %degrees = 'a'..'z' Z=> (26...1);
put $str.comb.map({ ++$ * %degrees{$_} }).sum;
