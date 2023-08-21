#!/bin/env raku

unit sub MAIN(*@N where @N.all ~~ Int);

my ($min, $max) = @N.min, @N.max;
my @normals = @N.grep(* != $min|$max);

put +@normals == 0 ?? -1 !! @normals;
