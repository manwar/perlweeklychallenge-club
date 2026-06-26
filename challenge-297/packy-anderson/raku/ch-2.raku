#!/usr/bin/env raku
use v6;

sub SOP(@ints) {
  my $n = @ints.elems;
  my ($pos_one, $pos_n);
  for 0..($n-1) -> $i {
    $pos_one = $i if @ints[$i] == 1;
    $pos_n   = $i if @ints[$i] == $n;
  }
  if ($pos_one < $pos_n) {
    return $pos_one + ($n-1) - $pos_n;
  }
  else {
    return $pos_one + ($n-1) - $pos_n - 1;
  }
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ SOP(@ints);
}

say "Example 1:";
solution([2, 1, 4, 3]);

say "\nExample 2:";
solution([2, 4, 1, 3]);

say "\nExample 3:";
solution([1, 3, 2, 4, 5]);

say "\nExample 4:";
solution([5, 4, 3, 2, 1]);

say "\nExample 5:";
solution([3, 1, 6, 4, 5, 7, 2]);
