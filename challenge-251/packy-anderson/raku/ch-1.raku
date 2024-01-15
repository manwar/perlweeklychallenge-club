#!/usr/bin/env raku
use v6;

sub concatenationValue(@ints) {
  return 0        if @ints.elems == 0; # no elements
  return @ints[0] if @ints.elems == 1; # one element

  my $first = @ints.shift; # first element
  my $last  = @ints.pop;   # last element
  my $concat = "$first$last".Int; # concatenate and convert

  return $concat + concatenationValue(@ints);
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my $value = concatenationValue(@ints);
  say "Output: $value";
}

say "Example 1:";
solution([6, 12, 25, 1]);

say "\nExample 2:";
solution([10, 7, 31, 5, 2, 2]);

say "\nExample 3:";
solution([1, 2, 10]);
