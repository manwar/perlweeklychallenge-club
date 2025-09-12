#!/usr/bin/env raku
use v6;

sub smallerThan(@num1) {
  my $bag = @num1.Bag;
  my @out;
  for 0..@num1.end -> $i {
    @out[$i] = $bag{ $bag.keys.grep({ $_ <= @num1[$i] }) }.sum - 1;
  }
  @out
}

sub solution(@num1) {
  say 'Input: @arr = (' ~ @num1.join(', ') ~ ')';
  my @out = smallerThan(@num1);
  say 'Output: (' ~ @out.join(', ') ~ ')';
}

say "Example 1:";
solution([6, 5, 4, 8]);

say "\nExample 2:";
solution([7, 7, 7, 7]);

say "\nExample 3:";
solution([5, 4, 3, 2, 1]);

say "\nExample 4:";
solution([-1, 0, 3, -2, 1]);

say "\nExample 5:";
solution([0, 1, 1, 2, 0]);
