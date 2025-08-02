#!/usr/bin/env raku
use v6;

sub powerSet(@array) {
  return @array.combinations: 0 .. @array.elems;
}

sub totalXOR(@ints) {
  my $sum = 0;
  for powerSet(@ints) -> @s {
    $sum += [+^] @s;
  }
  return $sum;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ totalXOR(@ints);
}

say "Example 1:";
solution([1, 3]);

say "\nExample 2:";
solution([5, 1, 6]);

say "\nExample 3:";
solution([3, 4, 5, 6, 7, 8]);
