#!/bin/env raku

unit sub MAIN(*@ints);

@ints                         ==>
grep(* > 0)                   ==>
my @v; max(+@v, +@ints - +@v) ==>
put()
