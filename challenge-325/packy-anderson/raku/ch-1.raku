#!/usr/bin/env raku
use v6;

sub consecutiveOne(@binary) {
  my $max = 0;
  my $consecutive = 0;
  for @binary -> $bit {
    if ($bit) {
      $consecutive++;
      $max = $consecutive if $consecutive > $max;
    }
    else {
      $consecutive = 0;
    }
  }
  return $max;
}

sub solution(@binary) {
  say 'Input: @binary = (' ~ @binary.join(', ') ~ ')';
  say 'Output: ' ~ consecutiveOne(@binary);
}

say "Example 1:";
solution([0, 1, 1, 0, 1, 1, 1]);

say "\nExample 2:";
solution([0, 0, 0, 0]);

say "\nExample 3:";
solution([1, 0, 1, 0, 1, 1]);

say "\nExample 4:";
solution([1, 1, 1, 0, 1, 1, 0]);

say "\nExample 5:";
solution([1, 0, 1, 1, 0, 1, 0]);
