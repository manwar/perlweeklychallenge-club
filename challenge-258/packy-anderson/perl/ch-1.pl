#!/usr/bin/env perl
use v5.38;

use POSIX qw( log10 floor );

sub evenDigitCount(@ints) {
  my $count = 0; # in case there are no even digit ints
  foreach my $n ( @ints ) {
    $count++ if floor(log10($n) + 1) % 2 == 0;
  }
  return $count;
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  say 'Output: ' . evenDigitCount(@ints);
}

say "Example 1:";
solution(10, 1, 111, 24, 1000);

say "\nExample 2:";
solution(111, 1, 11111);

say "\nExample 3:";
solution(2, 8, 1024, 256);
