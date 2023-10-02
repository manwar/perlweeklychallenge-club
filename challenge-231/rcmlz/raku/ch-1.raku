#!/usr/bin/env raku
use Test;

#|[Task 1: Min Max
- You are given an array of distinct integers.
- Write a script to find all elements that is 
  - neither minimum nor maximum. 
  - Return -1 if you can’t.
]
multi task1(@input) { -1 }
multi task1(@input where @input.elems > 2) {
  my $not-min-max = @input.Set ∖ (@input.min, @input.max).Set;
  $not-min-max.elems > 0 ?? $not-min-max !! -1; 
}

my @testcases = (
  {input => (3, 2, 1, 4), output=> (3, 2).Set, description=>"The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max."},
  {input => (3, 1), output=> -1, description=>"to short"},
  {input => (3, 3, 3, 4), output=> -1, description=>"only min and max"},
  {input => (2, 1, 3), output=> (2).Set, description=>"The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max."},
);

cmp-ok task1($_<input>), &[≡] ,$_<output>, $_<description> for @testcases;