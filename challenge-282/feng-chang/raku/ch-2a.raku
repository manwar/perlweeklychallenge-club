#!/bin/env raku

unit sub MAIN(Str:D $str is copy);

$str .= lc;
$str ~~ s:g/$<c>=(<[a..z]>) $<c>+/$<c>/;
put $str.chars - 1;
