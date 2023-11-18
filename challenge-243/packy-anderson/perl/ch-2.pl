#!/usr/bin/env perl
use v5.38;

sub floorSum {
  my @arr = @_;
  my $sum = 0;
  foreach my $i (0 .. $#arr) {
    foreach my $j (0 .. $#arr) {
      $sum += int($arr[$i] / $arr[$j]);
    }
  }
  return $sum;
}

sub solution {
  my @nums = @_;
  say 'Input: @nums = (' . join(', ', @nums) . ')';
  my $sum = floorSum(@nums);
  say 'Output: ' . $sum;
}

say "Example 1:";
solution(2, 5, 9);

say "\nExample 2:";
solution(7, 7, 7, 7, 7, 7, 7);