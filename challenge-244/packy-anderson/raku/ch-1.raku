#!/usr/bin/env raku
use v6;

sub countSmaller(@int) {
  my @counts;
  for @int.keys -> $i {
    @counts[$i] = 0;
    for @int.keys -> $j {
      @counts[$i]++ if @int[$j] < @int[$i];
    }
  }
  return @counts;
}

sub solution(*@int) {
  say 'Input: @int = (' ~ @int.join(', ') ~ ')';
  my @output = countSmaller(@int);
  say 'Output: (' ~ @output.join(', ') ~ ')';
}

say "Example 1:";
solution(8, 1, 2, 2, 3);

say "\nExample 2:";
solution(6, 5, 4, 8);

say "\nExample 3:";
solution(2, 2, 2);
