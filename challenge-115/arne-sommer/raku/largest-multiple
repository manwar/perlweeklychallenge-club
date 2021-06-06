#! /usr/bin/env raku

unit sub MAIN (*@N where @N.elems > 0 && all(@N) == any(0..9), :v(:$verbose));

my @all = @N.permutations>>.join.grep(* ~~ / <[02468]> $/).sort.reverse;

say ": { @all.join(", ") }" if $verbose && @all;

say @all[0] if @all[0] && @all[0] != 0;
