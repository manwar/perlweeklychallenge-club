#!/usr/bin/env raku

sub sum-of-values(@arr,$k)
{
  [+] (0..@arr.end).map: {([+] .base(2).comb) == $k ?? @arr[$_] !! ()}
}

say sum-of-values([2,5,9,11,3],1);
say sum-of-values([2,5,9,11,3],2);
say sum-of-values([2,5,9,11,3],0);

