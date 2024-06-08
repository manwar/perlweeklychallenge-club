#!/usr/bin/env raku
use v6;

sub bitwisePair(@ints) {
  my $first = @ints.shift;

  # if we have no more elements to
  # compare it to, return false
  return False if @ints.elems == 0;

  # bitwise OR the first element with
  # each of the remaining elements and
  # check if the result is even
  for @ints -> $next {
    return True if (($first +| $next) +& 1) == 0;
  }

  # search the remaining list for pairs
  return bitwisePair(@ints);
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ bitwisePair(@ints);
}

say "Example 1:";
solution([1, 2, 3, 4, 5]);

say "\nExample 2:";
solution([2, 3, 8, 16]);

say "\nExample 3:";
solution([1, 2, 5, 7, 9]);
