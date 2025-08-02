#! /usr/bin/env raku

unit sub MAIN ($word where $word.chars > 0, :v(:$verbose));

my $perm = $word.comb.sort.permutations>>.join.unique;

say ": Permutations: $perm[]" if $verbose;

my $index = ($perm.grep: $word, :k).first;

say $index +1;
