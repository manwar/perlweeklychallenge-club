#! /usr/bin/env raku

unit sub MAIN ($matrix, :v(:$verbose));

my @matrix = $matrix.split("|")>>.words>>.Numeric;

die "Uneven row length" unless [==] @matrix>>.elems;

die "Non numeric value(s) in the matrix" unless all(@matrix[*;*]) ~~ Numeric;

my @sum = @matrix>>.sum;

say ": Row sums: { @sum.join(",") }" if $verbose;

say @sum.max;
