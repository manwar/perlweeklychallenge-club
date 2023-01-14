#!/bin/env raku

unit sub MAIN(*@N);

if +@N < 2 { 0.put; exit }

^ (@N.elems - 1)          ==>
map { @N[$_+1] - @N[$_] } ==>
my @gaps; @gaps           ==>
grep { $_ == @gaps.max }  ==>
elems()                   ==>
put();
