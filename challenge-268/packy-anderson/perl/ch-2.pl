#!/usr/bin/env perl
use v5.38;

sub numberGame(@ints) {
  my @intSorted = sort @ints;
  my @new;
  while (@intSorted) {
    my $x = shift @intSorted;
    my $y = shift @intSorted;
    if ($x > $y) {
      push @new, $x, $y;
    }
    else {
      push @new, $y, $x;
    }
  }
  return @new;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my @new = numberGame(@$ints);
  say 'Output: (' . join(', ', @new) . ')';
}

say "Example 1:";
solution([2, 5, 3, 4]);

say "\nExample 2:";
solution([9, 4, 1, 3, 6, 4, 6, 1]);

say "\nExample 3:";
solution([1, 2, 2, 3]);