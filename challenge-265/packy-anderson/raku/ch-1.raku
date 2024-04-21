#!/usr/bin/env raku
use v6;

sub oneThirdAppearance(@ints) {
  my Int $smallest;
  my Rat $oneThird = @ints.elems / 3;
  my Int %seen;
  for @ints -> $i {
    if (++%seen{$i} >= $oneThird) {
      if (! $smallest.defined || $i < $smallest) {
        $smallest = $i;
      }
    }
  }
  return $smallest;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ oneThirdAppearance(@ints);
}

say "Example 1:";
solution([1,2,3,3,3,3,4,2]);

say "\nExample 2:";
solution([1,1]);

say "\nExample 3:";
solution([1,2,3]);