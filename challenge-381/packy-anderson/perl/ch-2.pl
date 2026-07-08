#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( minmax_by sum );
use List::MoreUtils qw( frequency );

sub smallerGreater(@int) {
  my %bag = frequency @int;
  return 0 if keys %bag < 3; # not enough unique elements
  my ($min, $max) = minmax_by { $_ + 0 } keys %bag;
  delete %bag{ $min }; # the smallest
  delete %bag{ $max }; # the greatest
  sum values %bag;
}

sub solution($int) {
  say 'Input: @int = (' . join(', ', @$int) . ')';
  say 'Output: ' . smallerGreater(@$int);
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
