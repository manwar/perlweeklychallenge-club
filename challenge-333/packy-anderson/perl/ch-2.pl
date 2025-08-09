#!/usr/bin/env perl
use v5.40;

sub duplicateZeros(@ints) {
  my $size = @ints;
  my @dest;
  while (@dest < $size) {
    my $i = shift @ints;
    push @dest, $i;
    push @dest, $i if $i == 0;
  }
  return splice(@dest, 0, $size);
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: (' . join(', ', duplicateZeros(@$ints)) . ')';
}

say "Example 1:";
solution([1, 0, 2, 3, 0, 4, 5, 0]);

say "\nExample 2:";
solution([1, 2, 3]);

say "\nExample 3:";
solution([1, 2, 3, 0]);

say "\nExample 43:";
solution([0, 0, 1, 2]);

say "\nExample 5:";
solution([1, 2, 0, 3, 4]);
