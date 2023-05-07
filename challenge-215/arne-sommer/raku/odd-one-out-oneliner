#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0 && all(@words) ~~ /^<[a..z]>+$/);

say @words.grep({ ! [<=] $_.ords }).elems;
