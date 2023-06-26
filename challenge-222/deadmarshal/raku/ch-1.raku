#!/usr/bin/env raku

sub matching-numbers(@arr)
{
  my @sorted = @arr.sort;
  my $sum = 0;
  for 0..@sorted.end -> $i
  {
    $sum++ if (@arr[$i] == @sorted[$i])
  }
  $sum
}

say matching-numbers([1,1,4,2,1,3]);
say matching-numbers([5,1,2,3,4]);
say matching-numbers([1,2,3,4,5]);

