#!/usr/bin/env raku
use v6;

sub evenDigitCount(@ints) {
  my $count = 0; # in case there are no even digit ints
  for @ints -> $n {
    $count++ if floor(log10($n) + 1) % 2 == 0;
  }
  return $count;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ evenDigitCount(@ints);
}

say "Example 1:";
solution([10, 1, 111, 24, 1000]);

say "\nExample 2:";
solution([111, 1, 11111]);

say "\nExample 3:";
solution([2, 8, 1024, 256]);
