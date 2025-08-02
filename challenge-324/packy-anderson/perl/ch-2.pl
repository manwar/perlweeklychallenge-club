#!/usr/bin/env perl
use v5.40;

use Algorithm::Combinatorics qw( subsets );
use List::AllUtils qw( reduce );

sub totalXOR($ints) {
  my $sum = 0;
  for my $s ( subsets($ints) ) {
    $sum += (reduce { $a ^ $b } @$s) // 0;
  }
  return $sum;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . totalXOR($ints);
}

say "Example 1:";
solution([1, 3]);

say "\nExample 2:";
solution([5, 1, 6]);

say "\nExample 3:";
solution([3, 4, 5, 6, 7, 8]);
