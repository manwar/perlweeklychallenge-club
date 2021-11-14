#! /usr/bin/env raku

unit sub MAIN (Str $S1, Str $S2);

my Int @S1 = $S1.words>>.Numeric;
my Int @S2 = $S2.words>>.Numeric;

die "@S1 has duplicates" unless @S1.elems == @S1.Set.elems;
die "@S2 has duplicates" unless @S2.elems == @S2.Set.elems;

say + ! so @S1 (&) @S2;
