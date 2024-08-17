#!/usr/bin/env raku
use v6;

sub isStrongPair($x, $y) {
  return 0 < abs($x - $y) < min($x, $y);
}

sub strongPairs(@ints) {
  my @strong;
  my @ints2 = @ints.unique.sort;
  for @ints2 -> $x {
    for @ints2 -> $y {
      next if $x > $y;
      next unless isStrongPair($x, $y);
      @strong.push("($x, $y)");
    }
  }
  return @strong.elems, @strong.join(', ');
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($count, $explain) = strongPairs(@ints);
  say "Output: $count\n\nStrong Pairs: $explain";
}

say "Example 1:";
solution([1, 2, 3, 4, 5]);

say "\nExample 2:";
solution([5, 7, 1, 7]);
