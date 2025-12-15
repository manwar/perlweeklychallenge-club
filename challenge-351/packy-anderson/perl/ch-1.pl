#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( min max sum );

sub specialAverage(@ints) {
  my $min = min @ints; # ok, using List::Utils functions to
  my $max = max @ints; # find min/max rather than a loop
  @ints = grep { $_ != $min && $_ != $max } @ints;
  return 0 if @ints == 0;
  return sum(@ints) / scalar(@ints);
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . specialAverage(@$ints);
}

say "Example 1:";
solution([8000, 5000, 6000, 2000, 3000, 7000]);

say "\nExample 2:";
solution([100_000, 80_000, 110_000, 90_000]);

say "\nExample 3:";
solution([2500, 2500, 2500, 2500]);

say "\nExample 4:";
solution([2000]);

say "\nExample 5:";
solution([1000, 2000, 3000, 4000, 5000, 6000]);
