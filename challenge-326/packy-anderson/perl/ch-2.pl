#!/usr/bin/env perl
use v5.40;

sub decompress(@ints) {
  my @out;
  for my ($i, $j) ( @ints ) {
    push @out, ($j) x $i;
  }
  @out
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my @out = decompress(@$ints);
  say 'Output: (' . join(', ', @out) . ')';
}

say "Example 1:";
solution([1, 3, 2, 4]);

say "\nExample 2:";
solution([1, 1, 2, 2]);

say "\nExample 3:";
solution([3, 1, 3, 2]);
