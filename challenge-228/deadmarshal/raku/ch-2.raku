#!/usr/bin/env raku

sub empty-array(@arr)
{
  my $count = 0;
  while @arr
  {
    @arr[0] == @arr.min ?? @arr.shift !! @arr.push(@arr.shift);
    $count++;
  }
  $count
}

say empty-array([3,4,2]);
say empty-array([1,2,3]);

