#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max );

sub thirdMaximum(@ints) {
  my %distinct; $distinct{$_}=1 for @ints; # get distinct integers
  if ((keys %distinct) < 3) {
    # not enough values for a third max, return max
    return max(keys %distinct);
  }
  # sort and then get the third from the end
  return( (sort keys %distinct)[-3] );
}

sub solution($ints) {
  say 'Input: @arr = (' . join(', ', @$ints) . ')';
  say 'Output: ' . thirdMaximum(@$ints);
}

say "Example 1:";
solution([5, 6, 4, 1]);

say "\nExample 2:";
solution([4, 5]);

say "\nExample 3:";
solution([1, 2, 2, 3]);
