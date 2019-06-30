#!/usr/bin/env perl6

use v6.d;

#| Generate <count> elements of Van Eck's Sequence or a Variation thereof
#| starting at <start>.
unit sub MAIN (
  UInt  $count = 19, #= Count of elements to generate; defaults to 19.
  UInt :$start = 0   #= Starting number of the Variation; defaults to 0.
);

my \Van_Eck := gather {
  take $start;
  my %m = $start => 0;

  for ^∞ -> $n {
    take %m{Van_Eck[$n]}:exists ?? $n - %m{Van_Eck[$n]} !! 0;
    %m{Van_Eck[$n]} = $n;
  }
}

# 0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5 ...
Van_Eck[^$count].put;
