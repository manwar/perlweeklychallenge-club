#! /usr/bin/env raku

subset alpha where * ~~ /^<[a..z A..Z]>+$/;

unit sub MAIN (alpha $s);

say $s ~~ /^<[a..z]>+$/ || $s ~~ /^<[A..Z]>+$/ || $s ~~ /^<[A..Z]><[a..z]>+$/
 ?? 1 !! 0;