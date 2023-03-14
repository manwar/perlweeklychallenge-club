#!/usr/bin/env raku

sub h-index(@arr)
{
  for 0..@arr.end -> $i {
    return $i if $i >= @arr[$i];
  }
}

say h-index([10,8,5,4,3]);
say h-index([25,8,5,3,3]);

