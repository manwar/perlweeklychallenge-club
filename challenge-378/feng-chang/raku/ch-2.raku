#!/bin/env raku

unit sub MAIN(*@s where +* == 3);

my method to-number(Str:D $s :) { $s.trans('a'..'j' => 0..9) }

put @s[0].&to-number + @s[1].&to-number == @s[2].&to-number;
