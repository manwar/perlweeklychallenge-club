#!/usr/bin/env raku
use v6;

sub smallerGreater(@int) {
  my %bag = @int.BagHash;
  return 0 if %bag.elems < 3; # not enough unique elements
  %bag{ %bag.keys.min(:by({ $_.Int })) }:delete; # the smallest
  %bag{ %bag.keys.max(:by({ $_.Int })) }:delete; # the greatest
  %bag.values.sum;
}

sub solution(@int) {
  say 'Input: @int = (' ~ @int.join(', ') ~ ')';
  say 'Output: ' ~ smallerGreater(@int);
}

say "Example 1:";
solution([2, 4]);

say "\nExample 2:";
solution([1, 1, 1, 1]);

say "\nExample 3:";
solution([1, 1, 4, 8, 12, 12]);

say "\nExample 4:";
solution([3, 6, 6, 9]);

say "\nExample 5:";
solution([0, -5, 10, -2, 4]);
