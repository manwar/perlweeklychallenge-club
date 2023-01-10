#!/bin/env raku

unit sub MAIN(*@N);

if +@N < 2 { 0.put; exit }

my \max-gap = (^(@N.elems-1)).map({ @N[$_+1] - @N[$_] }).max;
put (^(@N.elems-1)).grep({ max-gap == @N[$_+1] - @N[$_] }).elems;
