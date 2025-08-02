#!/usr/bin/env perl
use v5.38;

sub smallerThan(@ints) {
  my @counts;
  foreach my $i (0 .. $#ints) {
    @counts[$i] = 0;
    foreach my $j (0 .. $#ints) {
      next if $i == $j;
      $counts[$i]++ if $ints[$j] < $ints[$i];
    }
  }
  return @counts;
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my @counts = smallerThan(@ints);
  say 'Output: (' . join(', ', @counts) . ')';
}

say "Example 1:";
solution(5, 2, 1, 6);

say "\nExample 2:";
solution(1, 2, 0, 3);

say "\nExample 3:";
solution(0, 1);

say "\nExample 4:";
solution(9, 4, 9, 2);