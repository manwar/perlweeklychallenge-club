#!/usr/bin/env raku

sub next-permutation(@arr)
{
  @arr.permutations[1]
}

say next-permutation([1,2,3]);
say next-permutation([2,1,3]);
say next-permutation([3,1,2]);

