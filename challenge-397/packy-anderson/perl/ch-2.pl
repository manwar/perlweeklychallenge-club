#!/usr/bin/env perl
use v5.44;

sub sortByBinaryReflection(@arr) {
  sort {
    oct('0b'.reverse sprintf('%b', $a)) <=>
    oct('0b'.reverse sprintf('%b', $b))
  } @arr;
}

sub solution($arr) {
  say 'Input: @arr = (' . join(', ', @$arr) . ')';
  say 'Output: (' . join(', ', sortByBinaryReflection(@$arr)) . ')';
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
