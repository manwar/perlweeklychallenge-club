#!/usr/bin/env perl
use v5.40;

sub twiceLargest(@ints) {
  return -1 if @ints <= 1;
  my $largest = 0;
  my $second = -1;
  for my $i ( 1 .. $#ints ) {
    if ($ints[$i] > $ints[$largest]) {
      $second  = $largest;
      $largest = $i;
    }
    elsif ($second < 0 || $ints[$i] > $ints[$second]) {
      $second = $i;
    }
  }
  return $ints[$largest] >= 2 * $ints[$second] ? $largest : -1;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . twiceLargest(@$ints);
}

say "Example 1:";
solution([2, 4, 1, 0]);

say "\nExample 2:";
solution([1, 2, 3, 4]);

say "\nExample 3:";
solution([1]);

say "\nExample 4:";
solution([4, 2, 1]);
