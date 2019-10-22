#!/usr/bin/env perl
use warnings;
use strict;

# Problem:
# Write a script to print all possible series of 3 positive numbers,
# where in each series at least one of the number is even and sum of
# the three numbers is always 12. For example, 3,4,5.

# Answer:
# Let's do brute force.
# Start first counter from 1 (needs to be positive).
# Start second counter from the same place as first counter
#   to avoid duplicates like 3-4-5 4-3-5 4-5-3 etc.
# End at 10, as that will be max (1-1-10).

for my $i (1..10){
  for my $j ($i..10){
    for my $k ($j..10){
      if (
        ($i + $j + $k == 12) &&
        (($i % 2 == 0) || ($j % 2 == 0) || ($k % 2 == 0))
      ){
        print "$i + $j + $k = 12\n";
      }
    }
  }
}

# Output:
# 1 + 1 + 10 = 12
# 1 + 2 + 9 = 12
# 1 + 3 + 8 = 12
# 1 + 4 + 7 = 12
# 1 + 5 + 6 = 12
# 2 + 2 + 8 = 12
# 2 + 3 + 7 = 12
# 2 + 4 + 6 = 12
# 2 + 5 + 5 = 12
# 3 + 3 + 6 = 12
# 3 + 4 + 5 = 12
# 4 + 4 + 4 = 12
