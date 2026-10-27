#!/usr/bin/env raku
use v6;

sub sortByBinaryReflection(@arr) {
  @arr.sort: *.base(2).flip.parse-base(2);
}

sub solution(@arr) {
  say 'Input: @arr = (' ~ @arr.join(', ') ~ ')';
  say 'Output: (' ~ sortByBinaryReflection(@arr).join(', ') ~ ')';
}

say "Example 1:";
solution([3, 6, 12]);

say "\nExample 2:";
solution([1, 2, 4, 8]);

say "\nExample 3:";
solution([7, 8, 9, 10]);

say "\nExample 4:";
solution([5, 9, 15, 17]);

say "\nExample 5:";
solution([11, 13, 14, 19]);
