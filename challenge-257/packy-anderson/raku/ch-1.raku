#!/usr/bin/env raku
use v6;

sub smallerThan(@ints) {
  my @counts;
  for 0 .. @ints.end -> $i {
    @counts[$i] = 0;
    for 0 .. @ints.end -> $j {
      next if $i == $j;
      @counts[$i]++ if @ints[$j] < @ints[$i];
    }
  }
  return @counts;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @counts = smallerThan(@ints);
  say 'Output: (' ~ @counts.join(', ') ~ ')';
}

say "Example 1:";
solution([5, 2, 1, 6]);

say "\nExample 2:";
solution([1, 2, 0, 3]);

say "\nExample 3:";
solution([0, 1]);

say "\nExample 4:";
solution([9, 4, 9, 2]);