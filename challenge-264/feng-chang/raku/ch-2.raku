#!/bin/env raku

unit sub MAIN(Str $source, Str:D $indices);

use MONKEY-SEE-NO-EVAL;

my @src = EVAL "[$source]";
my @ndx = EVAL "[$indices]";
my @tgt;
@tgt.splice(@ndx[$_], 0, @src[$_]) for ^+@src;
put @tgt;
