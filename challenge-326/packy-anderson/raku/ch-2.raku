#!/usr/bin/env raku
use v6;

sub decompress(@ints) {
  my @out;
  for @ints -> $i, $j {
    @out.append($j xx $i);
  }
  @out
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @out = decompress(@ints);
  say 'Output: (' ~ @out.join(', ') ~ ')';
}

say "Example 1:";
solution([1, 3, 2, 4]);

say "\nExample 2:";
solution([1, 1, 2, 2]);

say "\nExample 3:";
solution([3, 1, 3, 2]);
