#!/usr/bin/env perl
use v5.40;

sub peakPositions(@ints) {
  my @peaks;
  foreach my $i (0 .. $#ints) {
    next unless $i == 0      || $ints[$i - 1] <= $ints[$i];
    next unless $i == $#ints || $ints[$i + 1] <= $ints[$i];
    push @peaks, $i;
  }
  return @peaks;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: (' . join(', ', peakPositions(@$ints)) . ')';
}

say "Example 1:";
solution([1, 3, 2]);

say "\nExample 2:";
solution([2, 4, 6, 5, 3]);

say "\nExample 3:";
solution([1, 2, 3, 2, 4, 1]);

say "\nExample 4:";
solution([5, 3, 1]);

say "\nExample 5:";
solution([1, 5, 1, 5, 1, 5, 1]);
