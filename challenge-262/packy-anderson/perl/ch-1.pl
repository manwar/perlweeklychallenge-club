#!/usr/bin/env perl
use v5.38;

use List::Util qw( max sum );

sub maxPosNeg(@ints) {
  my $pos = sum map { $_ > 0 ? 1 : 0 } @ints;
  my $neg = sum map { $_ < 0 ? 1 : 0 } @ints;
  my $max = max $pos, $neg;
  return (
    $max,
    join("\n",
      "Count of positive integers: $pos",
      "Count of negative integers: $neg",
      "Maximum of count of positive and " .
      "negative integers: $max"
    )
  );
}

sub solution(@ints) {
  say 'Input: @arr = (' . join(', ', @ints) . ')';
  my ($max, $explain) = maxPosNeg(@ints);
  say "Output: $max\n\n$explain";
}

say "Example 1:";
solution(-3, 1, 2, -1, 3, -2, 4);

say "\nExample 2:";
solution(-1, -2, -3, 1);

say "\nExample 3:";
solution(1,2);