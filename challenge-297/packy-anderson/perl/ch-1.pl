#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max sum );

sub contiguousArray(@arr) {
  # special case: all 0s or all 1s
  my $len = @arr;
  my $sum = sum @arr;
  return 0 if $sum == 0 || $sum == $len;
  
  # special case: entire array is equal
  return $len if $sum == $len/2;

  # generate subarrays and check
  my $max = 0;
  for my $i ( 0 .. $#arr - 1 ) {
    for my $j ( $i + 1 .. $#arr ) {
      my @subarr = @arr[$i .. $j];
      if (sum(@subarr) == scalar(@subarr)/2) {
        $max = max($max, scalar @subarr);
      }
    }
  }
  return $max;
}

sub solution($arr) {
  say 'Input: @arr = (' . join(', ', @$arr) . ')';
  say 'Output: ' . contiguousArray(@$arr);
}

say "Example 1:";
solution([1, 0]);

say "\nExample 2:";
solution([0, 1, 0]);

say "\nExample 3:";
solution([0, 0, 0, 0, 0]);

say "\nExample 4:";
solution([0, 1, 0, 0, 1, 0]);

say "\nExample 5:";
solution([1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 1]);
