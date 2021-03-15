#! /usr/bin/env raku

unit sub MAIN ($S);

say '"' ~ $S.words.reverse.join(" ") ~ '"';
