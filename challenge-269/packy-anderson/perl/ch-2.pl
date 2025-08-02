#!/usr/bin/env perl
use v5.38;

sub distributeElements(@ints) {
  # grab the first two elements off the given array
  # and put them in the two distribution arrays
  my @arr1 = ( shift @ints );
  my @arr2 = ( shift @ints );

  # loop through the remaining elements of the given array
  foreach my $i ( @ints ) {
    if ($arr1[-1] > $arr2[-1]) {
      push @arr1, $i;
    }
    else {
      push @arr2, $i;
    }
  }
  # concatenate the arrays together
  return @arr1, @arr2;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my @out = distributeElements(@$ints);
  say 'Output: (' . join(', ', @out) . ')';
}

say "Example 1:";
solution([2, 1, 3, 4, 5]);

say "\nExample 2:";
solution([3, 2, 4]);

say "\nExample 3:";
solution([5, 4, 3 ,8]);
