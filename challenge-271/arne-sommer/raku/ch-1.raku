#! /usr/bin/env raku

unit sub MAIN ($string = "0 0 | 1 1 | 0 0", :v(:$verbose));

my $matrix = $string.split("|")>>.words>>.Int>>.Array;

die "The rows must have the same size" unless [==] $matrix>>.elems;

die "Must contain 0s and 1s only" unless all($matrix[*;*]) ~~ one(0,1);

my @sum = $matrix>>.sum.pairs.sort({ $^b.value <=> $^a.value || $^a.key <=> $^b.key });

say ": index => sums: { @sum.raku } (zero based index)" if $verbose;

say 1 + @sum[0].key;
