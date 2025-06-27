#!/usr/bin/env raku
use v6;

sub missingInts(@ints) {
  my $set = @ints.Set;
  my @missing;
  for 1 .. @ints.elems -> $i {
    @missing.push($i) if $i ∉ $set;
  }
  return @missing;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @missing = missingInts(@ints);
  say 'Output: (' ~ @missing.join(', ') ~ ')';
}

say "Example 1:";
solution([1, 2, 1, 3, 2, 5]);

say "\nExample 2:";
solution([1, 1, 1]);

say "\nExample 3:";
solution([2, 2, 1]);
