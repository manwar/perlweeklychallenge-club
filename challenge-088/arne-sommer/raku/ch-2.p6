#! /usr/bin/env raku

# subset PositiveInt of Int where * > 0;

unit sub MAIN ($matrix where $matrix.IO.f && $matrix.IO.r, :v(:$verbose));

my @matrix = $matrix.IO.lines>>.words>>.map( * ~~ (/<[1..9]>\d*/) )>>.grep( *.defined )>>.Array;

my $rows = @matrix.elems;
my $cols = @matrix[0].elems;

die "All rows must have the same length" unless [==] @(@matrix)>>.elems;

my $row = 0;
my $col = 0;

my $direction = "E";

my @spiral;

say ": { @matrix[$row][$col] } Direction: $direction" if $verbose;

loop
{
  @spiral.push: @matrix[$row][$col];
  
  @matrix[$row][$col] = Any;

  if    $direction eq "E" && @matrix[$row][$col+1] { $col++; $direction = "E"; }
  elsif $direction eq "E" && @matrix[$row+1][$col] { $row++; $direction = "S"; }
  elsif $direction eq "S" && @matrix[$row+1][$col] { $row++; $direction = "S"; }
  elsif $direction eq "S" && @matrix[$row][$col-1] { $col--; $direction = "W"; }
  elsif $direction eq "W" && @matrix[$row][$col-1] { $col--; $direction = "W"; }
  elsif $direction eq "W" && @matrix[$row-1][$col] { $row--; $direction = "N"; }
  elsif $direction eq "N" && @matrix[$row-1][$col] { $row--; $direction = "N"; }
  elsif $direction eq "N" && @matrix[$row][$col+1] { $col++; $direction = "E"; }
  else
  {
    last;
  }
  say ": { @matrix[$row][$col] } Direction: $direction" if $verbose;
}

say "[ { @spiral.join(', ') } ]";

