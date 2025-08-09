#!/usr/bin/env raku
use v6;

sub duplicateZeros(@ints is copy) {
  my $size = @ints.elems;
  my @dest;
  while (@dest.elems < $size) {
    my $i = @ints.shift;
    @dest.push($i);
    @dest.push($i) if $i == 0;
  }
  return @dest.splice(0, $size);
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: (' ~ duplicateZeros(@ints).join(', ') ~ ')';
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
