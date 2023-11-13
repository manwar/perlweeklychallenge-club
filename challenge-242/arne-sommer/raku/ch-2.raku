#! /usr/bin/env raku

unit sub MAIN (Str $matrix = "1 1 0 | 1 0 1 | 0 0 0", :v(:$verbose));

my @matrix = $matrix.split("|")>>.words>>.Array;
my @rows   = @matrix>>.elems;

die "Must have at least 1 row" unless @rows.elems >= 1;
die "The rows must have the same size" unless [==] @rows;
die "Must contain 0 and 1 only" unless all(@matrix[*;*]) eq any(0,1);
die "Must have the same number of columns and rows" unless @rows.elems == @rows[0];

my @reverse  = @matrix>>.Int>>.reverse>>.Array;
my @inverted = @reverse>>.&invert;

say ": Matrix:   { @matrix.raku }"  if $verbose;
say ": Reverse:  { @reverse.raku }" if $verbose;

say @inverted.List.raku;

multi sub invert (*@bool)
{
  return |@bool.map( + ! * ).Array;
}
