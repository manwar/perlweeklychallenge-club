#! /usr/bin/env raku

subset PosInt of Int where $_ > 0;

unit sub MAIN (PosInt $i, PosInt $j, PosInt $k where 1 <= $k <= $i * $j, :v(:$verbose));

my @result;

for 1 .. $i -> $ii
{
  for 1 .. $j -> $jj
  {
    @result.push: $ii * $jj;
  }
}

my @sorted = @result.sort;

say ": Sorted: @sorted[]" if $verbose;

say @sorted[$k -1];
