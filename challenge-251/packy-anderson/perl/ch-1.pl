#!/usr/bin/env perl
use v5.38;

sub concatenationValue(@ints) {
  return 0        if @ints == 0; # no elements
  return $ints[0] if @ints == 1; # one element

  my $first = shift @ints; # first element
  my $last  = pop @ints;   # last element
  my $concat = "$first$last"+0; # concatenate and convert

  return $concat + concatenationValue(@ints);
}

sub solution(@ints) {
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my $value = concatenationValue(@ints);
  say "Output: $value";
}

say "Example 1:";
solution(6, 12, 25, 1);

say "\nExample 2:";
solution(10, 7, 31, 5, 2, 2);

say "\nExample 3:";
solution(1, 2, 10);
