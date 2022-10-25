#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.e = 'ex01.txt');

my (\sd-foo, \ed-foo, \sd-bar, \ed-bar) =
    $f.IO.lines.comb(/\d\d '-' \d\d/)».comb.map({ "{.[3]}{.[4]}-{.[0]}{.[1]}" });

my \year = '2022';
put (("{year}-{sd-foo}".Date .. "{year}-{ed-foo}".Date) (&)
     ("{year}-{sd-bar}".Date .. "{year}-{ed-bar}".Date)
    ).elems, ' day(s)';
