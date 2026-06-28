#!/usr/bin/env raku
use v6;

sub contiguousArray(@arr) {
  # special case: all 0s or all 1s
  my $len = @arr.elems;
  my $sum = @arr.sum;
  return 0 if $sum == 0 || $sum == $len;
  
  # special case: entire array is equal
  return $len if $sum == $len/2;

  # generate subarrays and check
  my $max = 0;
  for 0 .. @arr.end - 1 -> $i {
    for $i + 1 .. @arr.end -> $j {
      my @subarr = @arr[$i .. $j];
      if (@subarr.sum == @subarr.elems/2) {
        $max = max($max, @subarr.elems);
      }
    }
  }
  return $max;
}

sub solution(@arr) {
  say 'Input: @arr = (' ~ @arr.join(', ') ~ ')';
  say 'Output: ' ~ contiguousArray(@arr);
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
