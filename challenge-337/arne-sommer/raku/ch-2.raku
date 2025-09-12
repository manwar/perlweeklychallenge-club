#! /usr/bin/env raku

unit sub MAIN (*@locations where @locations.elems > 0
                 && all(@locations) ~~ /^\d+\,\d+$/,
               UInt :r(:$row) where $row > 0,
	       UInt :c(:$col) where $col > 0,
               :v(:$verbose));

my @matrix = [0 xx $col] xx $row;

say ": Initial matrix: { @matrix.raku }" if $verbose;

for @locations -> $location
{
  my ($r, $c) = $location.split(',');

  die "Row $r is out of scope" if $r > $row;
  die "Col $c is out of scope" if $c > $col;

  @matrix[$r][$_]++ for ^$col;
  @matrix[$_][$c]++ for ^$row;

  say ": Row: $r, Col: $c -> { @matrix.raku }" if $verbose;
}

say @matrix[*;*].grep( ! ( * %% 2 ) ).elems;
