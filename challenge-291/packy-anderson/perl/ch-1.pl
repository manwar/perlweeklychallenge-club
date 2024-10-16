#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub middleIndex(@ints) {
  foreach my $i ( 0 .. $#ints ) {
    my $leftSum =
      $i == 0 ? 0 : sum @ints[0 .. $i - 1];
    my $rightSum =
      $i == $#ints ? 0 : sum @ints[$i + 1 .. $#ints];
    return $i if $leftSum == $rightSum;
  }
  return -1;
}

sub solution($ints) {
  say 'Input: @arr = (' . join(', ', @$ints) . ')';
  say 'Output: ' . middleIndex(@$ints);
}

say "Example 1:";
solution([2, 3, -1, 8, 4]);

say "\nExample 2:";
solution([1, -1, 4]);

say "\nExample 3:";
solution([2, 5]);

say "\nExample 4:";
solution([0, 5]);
