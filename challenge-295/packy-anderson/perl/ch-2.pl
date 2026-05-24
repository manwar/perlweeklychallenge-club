#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( min );

sub might_as_well($i, $jumps, @ints) {
  my $max_steps = $ints[$i];
  return $jumps if $i + $max_steps >= $#ints;
  return -1     if $max_steps == 0; # dead end
  my @min_steps;
  for my $j ( reverse 1 .. $max_steps ) {
    my $steps = might_as_well($i + $j, $jumps+1, @ints);
    next if $steps == -1; # dead end
    push @min_steps, $steps;
  }
  @min_steps ? min(@min_steps) : -1;
}

sub jump(@ints) {
  return 0 if @ints == 1; # we're already at the end
  might_as_well(0, 1, @ints);
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . jump(@$ints);
}

say "Example 1:";
solution([2, 3, 1, 1, 4]);

say "\nExample 2:";
solution([2, 3, 0, 4]);

say "\nExample 3:";
solution([2, 0, 0, 4]);

say "\nExample 4:";
solution([3, 0, 0, 4]);

say "\nExample 5:";
solution([1, 2, 3, 4, 5]);

say "\nExample 6:";
solution([0]);