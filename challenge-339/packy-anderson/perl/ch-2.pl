#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( max reductions );

sub peakPoint(@gain) {
  max reductions { $a + $b } 0, @gain;
}

sub solution($gain) {
  say 'Input: @gain = (' . join(', ', @$gain) . ')';
  say 'Output: ' . peakPoint(@$gain);
}

say "Example 1:";
solution([-5, 1, 5, -9, 2]);

say "\nExample 2:";
solution([10, 10, 10, -25]);

say "\nExample 3:";
solution([3, -4, 2, 5, -6, 1]);

say "\nExample 4:";
solution([-1, -2, -3, -4]);

say "\nExample 5:";
solution([-10, 15, 5]);

