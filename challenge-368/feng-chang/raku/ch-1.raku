#!/bin/env raku

unit sub MAIN(Str:D $str, Str:D $char);

my @str = $str.comb;
put @str.grep($char, :k).map({ @str[(^$str.chars).grep(*!=$_)].join }).max;
