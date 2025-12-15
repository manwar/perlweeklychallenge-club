#!/usr/bin/env raku
use v6;

sub arithmeticProgression(@ints) {
  @ints = @ints.sort;
  my $prev = @ints.shift;
  my $diff = @ints[0] - $prev; # calc first difference
  for @ints -> $cur {
    return False if $diff != $cur - $prev;
    $prev = $cur;
  }
  return True;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ arithmeticProgression(@ints);
}

say "Example 1:";
solution([1, 3, 5, 7, 9]);

say "\nExample 2:";
solution([9, 1, 7, 5, 3]);

say "\nExample 3:";
solution([1, 2, 4, 8, 16]);

say "\nExample 4:";
solution([5, -1, 3, 1, -3]);

say "\nExample 5:";
solution([1.5, 3, 0, 4.5, 6]);
