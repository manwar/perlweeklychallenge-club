#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose));

my @words = $*PROGRAM.slurp.split(/\s+/);

say ": words: { @words.map("'" ~ * ~ "'").join(",") }" if $verbose;

say @words.pick;