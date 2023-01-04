#!/usr/bin/env raku

sub max-gap(@arr)
{
  return 0 if @arr.elems < 2;
  @arr = @arr.sort();
  my ($max,$count) = (0,0);
  for @arr -> $i,$j {
    $max = $j - $i if $j - $i > $max;
  }
  my ($i,$j) = (0,1);
  while $j < @arr.elems {
    $count++ if @arr[$j] - @arr[$i] == $max;
    $i++;
    $j++;
  }
  $count;
}

say max-gap([2,5,8,1]);
say max-gap([3]);

