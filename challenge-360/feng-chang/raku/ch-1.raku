#!/bin/env raku

unit sub MAIN(Str:D $str, UInt:D $width);

my $left-pad = max(0, ($width - $str.chars) div 2);
put '*' x $left-pad,
    $str,
    '*' x ($width - $str.chars - $left-pad);
