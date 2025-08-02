#!/usr/bin/env raku
use v6;

sub maxCount(@ints) {
  my ($pos, $neg) = (0, 0);
  for @ints -> $int {
    if ($int > 0) {
      $pos++;
    }
    elsif ($int < 0) {
      $neg++;
    }
  }
  my $max = ($pos, $neg).max;
  my $explain =
    "There are $pos positive integers.\n" ~
    "There are $neg negative integers.\n" ~
    "The maximum between $pos and $neg is $max.";
  return ($max, $explain);
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($max, $explain) = maxCount(@ints);
  say "Output: $max\n\n$explain";
}

say "Example 1:";
solution([-3, -2, -1, 1, 2, 3]);

say "\nExample 2:";
solution([-2, -1, 0, 0, 1]);

say "\nExample 3:";
solution([1, 2, 3, 4]);
