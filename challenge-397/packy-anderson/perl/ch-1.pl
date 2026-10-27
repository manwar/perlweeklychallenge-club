#!/usr/bin/env perl
use v5.44;

use List::AllUtils qw( any max sum );
use POSIX qw( ceil );

sub absentSmallestPositive(@arr) {
  my $avg = sum(@arr) / scalar(@arr);
  my $pos = ceil($avg);    # smallest integer not less than num
  $pos = max($pos, 1);     # require positive number
  $pos++ if $pos == $avg;  # require strictly greater than num
  $pos++ while any {$pos == $_} @arr; # require num not in array
  return $pos;
}

sub solution($arr) {
  say 'Input: @arr = (' . join(', ', @$arr) . ')';
  say 'Output: ' . absentSmallestPositive(@$arr);
}

say "Example 1:";
solution([1, 2, 4, 5, 6]);

say "\nExample 2:";
solution([-5, -2, -1, 3]);

say "\nExample 3:";
solution([1, 2, 3]);

say "\nExample 4:";
solution([2, 3, 7, 8]);

say "\nExample 5:";
solution([1, 1, 1, 10]);

