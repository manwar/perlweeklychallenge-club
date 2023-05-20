#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems > 0 && all(@list) ~~ /^<[1..9]><[0..9]>*$/, :v(:$verbose));

my @permutations = @list.permutations;
my @values       = @permutations>>.join;

say ":Permutations: ", @permutations if $verbose;
say ":Values: ",       @values       if $verbose;

say @values.max;
