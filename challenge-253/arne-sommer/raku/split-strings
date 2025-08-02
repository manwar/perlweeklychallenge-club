#! /usr/bin/env raku

unit sub MAIN ($separator where $separator.chars == 1,
               *@words where @words.elems > 0);

say @words>>.split($separator).[*;*].grep( *.chars ).map( '"' ~ * ~ '"' ).join(",");
