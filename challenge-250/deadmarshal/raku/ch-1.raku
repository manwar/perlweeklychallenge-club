#!/usr/bin/env raku

sub smallest_index(@arr)
{
  (0..@arr.end).map: {return $_ if $_ % 10 == @arr[$_]}
  -1
}

say smallest_index([0,1,2]);
say smallest_index([4,3,2,1]);
say smallest_index([1,2,3,4,5,6,7,8,9,0]);

