#!/usr/bin/env raku

sub max-diff(@arr)
{
  my @s = @arr.sort;
  ([*] @s.tail(2)) - ([*] @s.head(2))
}

say max-diff([5,9,3,4,6]);
say max-diff([1,-2,3,-4]);
say max-diff([-3,-1,-2,-4]);
say max-diff([10,2,0,5,1]);
say max-diff([7,8,9,10,10]);

