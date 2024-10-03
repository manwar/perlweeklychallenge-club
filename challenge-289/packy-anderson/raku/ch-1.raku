#!/usr/bin/env raku
use v6;

sub thirdMaximum(@ints) {
  my %distinct = @ints.Bag; # get distinct integers
  if (%distinct.elems < 3) {
    # not enough values for a third max, return max
    return %distinct.keys.max();
  }
  # sort and then get the third from the end
  return( (%distinct.keys.sort)[*-3] );
}

sub solution(@ints) {
  say 'Input: @arr = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ thirdMaximum(@ints);
}

say "Example 1:";
solution([5, 6, 4, 1]);

say "\nExample 2:";
solution([4, 5]);

say "\nExample 3:";
solution([1, 2, 2, 3]);
