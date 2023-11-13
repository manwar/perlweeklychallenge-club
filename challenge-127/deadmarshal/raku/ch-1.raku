#!/usr/bin/env raku

sub disjoint-sets(@arr1,@arr2)
{
  !so @arr1 (&) @arr2;
}

say disjoint-sets([1,2,5,3,4],[4,6,7,8,9]);
say disjoint-sets([1,3,5,7,9],[0,2,4,6,8]);

