#! /usr/bin/env raku

unit sub MAIN ($string = "1 0 0 | 0 0 1 | 1 0 0",
               :v(:$verbose));

my $matrix = $string.split("|")>>.words>>.Int>>.Array;

die "The rows must have the same size" unless [==] $matrix>>.elems;

die "Must contain 0s and 1s only" unless all($matrix[*;*]) ~~ one(0,1);

my $rows  = $matrix.elems;
my $cols  = $matrix[0].elems;
my $count = 0;

say ": matrix: $matrix" if $verbose;

for ^$rows -> $row
{
  for ^$cols -> $col
  {
    my $val     = $matrix[$row][$col];
    my $row_sum = $matrix[$row;*].sum;
    my $col_sum = $matrix[*;$col].sum;

    say ": r: $row c: $col v: $val row: $matrix[$row;*] -> $row_sum col: $matrix[*;$col] -> $col_sum" if $verbose;

    next unless $val     == 1;
    next unless $row_sum == 1;
    next unless $col_sum == 1;

    $count++;
 
    say ": - is Special #$count" if $verbose;
  }
}

say $count;
