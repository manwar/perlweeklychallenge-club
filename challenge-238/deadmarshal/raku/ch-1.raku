#!/usr/bin/env raku

sub running-sum(@arr)
{
  [\+] @arr
}

say running-sum([1,2,3,4,5]);
say running-sum([1,1,1,1,1]);
say running-sum([0,-1,1,2]);

