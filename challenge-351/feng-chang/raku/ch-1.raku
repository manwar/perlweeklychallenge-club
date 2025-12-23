#!/bin/env raku

unit sub MAIN(*@ints);

my ($min, $max) = @ints.min, @ints.max;
@ints .= grep(* != ($min,$max).any);
put +@ints > 0 ?? @ints.sum/+@ints !! 0;
