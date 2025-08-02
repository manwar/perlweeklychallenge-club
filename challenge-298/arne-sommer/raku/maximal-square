#! /usr/bin/env raku

unit sub MAIN (Str $matrix = "1 0 1 0 0 | 1 0 1 1 1 | 1 1 1 1 1 | 1 0 0 1 0", :v(:$verbose));

my @matrix = $matrix.split("|")>>.words>>.Numeric;

die "Illegal characters" unless all(@matrix[*;*]) ~~ 0 | 1;

die "Uneven row length" unless [==] @matrix>>.elems;

my $rows = @matrix.elems;
my $cols = @matrix[0].elems;
my $max  = 0;

for ^$rows -> $row
{
  for ^$cols -> $col
  {
    if @matrix[$row][$col] == 0
    {
      say ": [r:$row,c:$col] - Skipping zero" if $verbose;
      next;
    }

    my $max-size = min($rows - $row, $cols - $col);

    say ": [r:$row,c:$col] maxbox: $max-size" if $verbose;

OUTERBOX:
    for 1 .. $max-size -> $size
    {
      for $row .. $row + $size -1 -> $r
      {
        for $col .. $col + $size -1 -> $c
        {
	  say ": [r:$r,c:$c] -> @matrix[$r][$c]" if $verbose;
          last OUTERBOX if @matrix[$r][$c] == 0;
        }
      }

      say ": Found 1-box $size x $size at [$row,$col]" if $verbose;

      $max = max($max, $size * $size)
    }
  }
}

say $max;
