#!/usr/bin/env raku
use v6;

sub absentSmallestPositive(@arr) {
  my $avg = @arr.sum / @arr.elems;
  my $pos = $avg.ceiling; # smallest integer not less than num
  $pos = max($pos, 1);    # require positive number
  $pos++ if $pos == $avg; # require strictly greater than num
  $pos++ while $pos == @arr.any; # require num not in array
  return $pos;
}

sub solution(@arr) {
  say 'Input: @arr = (' ~ @arr.join(', ') ~ ')';
  say 'Output: ' ~ absentSmallestPositive(@arr);
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
