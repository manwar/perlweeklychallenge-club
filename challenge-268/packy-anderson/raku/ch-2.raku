#!/usr/bin/env raku
use v6;

sub numberGame(@ints) {
  my @intSorted = @ints.sort;
  my @new;
  while (@intSorted) {
    my $x = @intSorted.shift;
    my $y = @intSorted.shift;
    if ($x > $y) {
      @new.push: ($x, $y).Slip;
    }
    else {
      @new.push: ($y, $x).Slip;
    }
  }
  return @new;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @new = numberGame(@ints);
  say 'Output: (' ~ @new.join(', ') ~ ')';
}

say "Example 1:";
solution([2, 5, 3, 4]);

say "\nExample 2:";
solution([9, 4, 1, 3, 6, 4, 6, 1]);

say "\nExample 3:";
solution([1, 2, 2, 3]);