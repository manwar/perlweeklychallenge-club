#!/usr/bin/env perl
use v5.40;

sub arithmeticProgression(@ints) {
  @ints = sort { $a <=> $b } @ints;
  my $prev = shift @ints;
  my $diff = $ints[0] - $prev; # calc first difference
  foreach my $cur (@ints) {
    return 'False' if $diff != $cur - $prev;
    $prev = $cur;
  }
  return 'True';
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . arithmeticProgression(@$ints);
}

say "Example 1:";
solution([1, 3, 5, 7, 9]);

say "\nExample 2:";
solution([9, 1, 7, 5, 3]);

say "\nExample 3:";
solution([1, 2, 4, 8, 16]);

say "\nExample 4:";
solution([5, -1, 3, 1, -3]);

say "\nExample 5:";
solution([1.5, 3, 0, 4.5, 6]);

