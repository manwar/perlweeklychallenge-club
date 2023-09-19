#!/usr/bin/env perl
 
use v5.38;

sub duplicateZeros {
  my @ints = @_;
  for (my $i = 0; $i < scalar(@ints); $i++) {
    if ($ints[$i] == 0) {
      splice(@ints, $i+1, 0, 0); # insert a 0 at $i+1
      splice(@ints, -1);         # pop the last element off @ints
      $i++; # skip over the 0 we added!
    }
  }
  return @ints;
}

sub solution {
  my @ints = @_;
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  @ints = duplicateZeros(@ints);
  say 'Output: (' . join(', ', @ints) . ')';
}
 
say "Example 1:";
solution(1, 0, 2, 3, 0, 4, 5, 0);
 
say "\nExample 2:";
solution(1, 2, 3);
 
say "\nExample 3:";
solution(0, 3, 0, 4, 5);