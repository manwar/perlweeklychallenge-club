#!/usr/bin/env raku

use v6;

sub findTriplets(@ints where ($_.all ~~ Int)) {
  my @solutions;
  for 0 .. @ints.elems - 3 -> $i {
    for $i + 1 .. @ints.elems - 2 -> $j {
      for $j + 1 .. @ints.elems - 1 -> $k {
        if (@ints[$i] != @ints[$j] &&
            @ints[$j] != @ints[$k] &&
            @ints[$i] != @ints[$k]) {
          push @solutions, [$i, $j, $k];
        }
      }
    }
  }
  return @solutions;
}

sub solution {
  my @ints = @_;
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @solutions = findTriplets(@ints);
  say 'Output: ' ~ @solutions.elems;
  say "" if @solutions;
  for @solutions -> @triplet {
    my ($i, $j, $k) = @triplet;
    say "($i, $j, $k) because "
      ~ "@ints[$i] != @ints[$j] != @ints[$k]";
  }
}

say "Example 1:";
solution(4, 4, 2, 4, 3);

say "\nExample 2:";
solution(1, 1, 1, 1, 1);

say "\nExample 3:";
solution(4, 7, 1, 10, 7, 4, 1, 1);