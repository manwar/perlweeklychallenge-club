#! /usr/bin/env raku

unit sub MAIN (Int $x, Int $y, Int $z, *@array where @array.elems > 0 && all(@array) ~~ /^<[0..9]>*$/, :v(:$verbose));

my $triplets = 0;

for 0 .. @array.end - 2 -> $i
{
  for $i + 1 .. @array.end - 1 -> $j
  {
    for $j + 1 .. @array.end -> $k
    {
      next unless abs(@array[$i] - @array[$j]) <= $x;
      next unless abs(@array[$j] - @array[$k]) <= $y;
      next unless abs(@array[$i] - @array[$k]) <= $z;

      $triplets++;

      say ": (@array[$i, $j, $k]) where (i=$i, j=$j, k=$k)" if $verbose;
    }
  }
}

say $triplets;
