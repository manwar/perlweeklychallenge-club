#!/usr/bin/env raku
use v6;

sub middleIndex(@ints) {
  for 0 .. @ints.end -> $i {
    my $leftSum =
      $i == 0 ?? 0 !! [+] @ints[0 .. $i - 1];
    my $rightSum =
      $i == @ints.end ?? 0 !! [+] @ints[$i + 1 .. *-1];
    return $i if $leftSum == $rightSum;
  }
  return -1;
}

sub solution(@ints) {
  say 'Input: @arr = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ middleIndex(@ints);
}

say "Example 1:";
solution([2, 3, -1, 8, 4]);

say "\nExample 2:";
solution([1, -1, 4]);

say "\nExample 3:";
solution([2, 5]);

say "\nExample 4:";
solution([0, 5]);
