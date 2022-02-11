#!/bin/env raku

unit sub MAIN(Str:D $a, Str:D $b);

my @fibo-words = $a, $b, * ~ * ... *.chars ≥ 51;
put @fibo-words[*-1].substr(50,1);
