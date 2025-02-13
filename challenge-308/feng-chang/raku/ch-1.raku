#!/bin/env raku

unit sub MAIN(Str:D $str1, Str:D $str2);

put +($str1.words (&) $str2.words);
