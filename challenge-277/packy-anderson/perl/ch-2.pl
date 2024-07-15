#!/usr/bin/env perl
use v5.40;

use List::Util qw( min uniq );

sub isStrongPair($x, $y) {
  return 0 < abs($x - $y) < min($x, $y);
}

sub strongPairs(@ints) {
  my @strong;
  my @ints2 = uniq sort @ints;
  foreach my $x ( @ints2 ) {
    foreach my $y ( @ints2 ) {
      next if $x > $y;
      next unless isStrongPair($x, $y);
      push @strong, "($x, $y)";
    }
  }
  return scalar(@strong), join(', ', @strong);
}

sub solution(@ints) {
  say 'Input: @ints = (' . @ints.join(', ') . ')';
  my ($count, $explain) = strongPairs(@ints);
  say "Output: $count\n\nStrong Pairs: $explain";
}

say "Example 1:";
solution(1, 2, 3, 4, 5);

say "\nExample 2:";
solution(5, 7, 1, 7);
