#! /usr/bin/env raku

unit sub MAIN (Int $n where $n > 0);

say (0 .. (1 x $n).parse-base(2)).map( *.fmt('%0' ~ $n ~ 'b') ).join(", ");
