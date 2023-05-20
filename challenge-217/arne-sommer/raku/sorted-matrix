#! /usr/bin/env raku

unit sub MAIN (Str $matrix = "3 1 2 | 5 2 4 | 0 1 3", :v(:$verbose));

my @matrix = $matrix.split("|")>>.words;
my @size   = @matrix>>.elems;

die "Must have at least 2 rows" unless @size.elems >= 2;
die "The rows must have the same size" unless [==] @size;
die "The number of columns and rows must be the same" unless @size[0] == @size.elems;

my @sorted = @matrix[*;*].sort;

say ":Sorted: { @sorted.join(",") }" if $verbose;

say @sorted[2];
