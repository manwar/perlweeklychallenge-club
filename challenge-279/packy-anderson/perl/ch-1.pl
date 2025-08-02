#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( zip );

sub sortLetters($letters, $weights) {
  my %letters = zip @$weights, @$letters;
  return join q{}, map {
    $letters{$_}
  } sort { $a <=> $b } keys %letters;
}

sub solution($letters, $weights) {
  say 'Input: @letters = (\'' . join('\', \'', @$letters) . '\')';
  say '       @weights = ('   . join(', ',     @$weights) . ')';
  say 'Output: ' . sortLetters($letters, $weights);
}

say "Example 1:";
solution(
  ['R', 'E', 'P', 'L'], [3, 2, 1, 4]
);

say "\nExample 2:";
solution(
  ['A', 'U', 'R', 'K'], [2, 4, 1, 3]
);

say "\nExample 3:";
solution(
  ['O', 'H', 'Y', 'N', 'P', 'T'], [5, 4, 2, 6, 1, 3]
);

say "\nExample 4:";
solution(
  [ 'C', 'd', 'F', 'i', 'l', 'n', 'o', 'o', 's', 'u'],
  [  1,   4,   5,   8,   3,  10,   9,   2,   7,   6]
);