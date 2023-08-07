#!/bin/env raku

unit sub MAIN(Str:D $f where *.IO.f);

my @array = $f.IO.lines.map({ .words».Int });

my Set $s1 = @array[0] (&) @array[1];
my Set $s2 = @array[1] (&) @array[2];
my Set $s3 = @array[2] (&) @array[0];
put ($s1 (|) $s2 (|) $s3).keys.sort;
