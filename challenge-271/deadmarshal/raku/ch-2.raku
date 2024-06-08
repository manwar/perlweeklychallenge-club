#!/usr/bin/env raku

sub population-count(Int $n where * >= 0)
{
  [+] $n.base(2).comb
}

sub sort-by-one-bits(@arr)
{
  @arr.sort: {population-count($^a) <=> population-count($^b) || $^a <=> $^b}
}

say sort-by-one-bits([0,1,2,3,4,5,6,7,8]);
say sort-by-one-bits([1024,512,256,128,64]);

