#! /usr/bin/env raku

unit sub MAIN ($string = "1 0 0 0 | 1 1 1 1  | 1 0 0 0 | 1 0 0 0", :v(:$verbose));

my $matrix = $string.split("|")>>.words>>.Int>>.Array;
my @values = $matrix[*;*];

die "The rows must have the same size" unless [==] $matrix>>.elems;
die "0 and 1 only" unless all(@values) ~~ any(0,1);
die "1 before 0 only" unless $matrix>>.reduce( &infix:«>=» );

my @pairs  = $matrix>>.sum.pairs;
my @sorted = @pairs.sort({ $^a.value <=> $^b.value || $^a.key <=> $^b.key });

say ":Pairs:  { @pairs.raku }"  if $verbose;
say ":Sorted: { @sorted.raku }" if $verbose;

say "({ @sorted>>.key.join(", ") })";
