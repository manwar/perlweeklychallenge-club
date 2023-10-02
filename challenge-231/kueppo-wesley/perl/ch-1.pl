#!/usr/bin/env perl


# You are given an array of distinct integers.
# 
# Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.
# 
# Example 1
# Input: @ints = (3, 2, 1, 4)
# Output: (3, 2)
# 
# The minimum is 1 and maximum is 4 in the given array. So (3, 2) is neither min nor max.
# Example 2
# Input: @ints = (3, 1)
# Output: -1
# Example 3
# Input: @ints = (2, 1, 3)
# Output: (2)
# 
# The minimum is 1 and maximum is 3 in the given array. So 2 is neither min nor max.

use strict;
use warnings;
use feature qw(signatures);

use List::Util qw(min max);
use Test::More;

sub not_minmax($a) {
   my ($min, $max) = (min(@$a), max(@$a));

   @$a = grep { $_ != $min && $_ != $max } @$a;
   return @$a ? $a : -1;
}

is_deeply(not_minmax([3, 2, 1, 4]), [3, 2], "ok?");
is_deeply(not_minmax([2, 1, 3]), [2], "ok?");
is(not_minmax([3, 1]), -1, "ok?");

done_testing(3);
