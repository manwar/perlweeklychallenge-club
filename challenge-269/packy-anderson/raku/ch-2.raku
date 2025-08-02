#!/usr/bin/env raku
use v6;

sub distributeElements(@ints) {
  # grab the first two elements off the given array
  # and put them in the two distribution arrays
  my @arr1 = ( @ints.shift );
  my @arr2 = ( @ints.shift );

  # loop through the remaining elements of the given array
  for @ints -> $i {
    if (@arr1[*-1] > @arr2[*-1]) {
      @arr1.push($i);
    }
    else {
      @arr2.push($i);
    }
  }
  # concatenate the arrays together
  return flat(@arr1, @arr2);
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @out = distributeElements(@ints);
  say 'Output: (' ~ @out.join(', ') ~ ')';
}

say "Example 1:";
solution([2, 1, 3, 4, 5]);

say "\nExample 2:";
solution([3, 2, 4]);

say "\nExample 3:";
solution([5, 4, 3 ,8]);
