#!/usr/bin/env raku
use v6;

sub buildArray(@old) {
  my @new;
  for 0 .. @old.elems - 1 -> $i {
    @new.push(@old[@old[$i]]);
  }
  return @new;
}

sub solution(*@int) {
  say 'Input: @int = (' ~ @int.join(', ') ~ ')';
  my @output = buildArray(@int);
  say 'Output: (' ~ @output.join(', ') ~ ')';
}

say "Example 1:";
solution(0, 2, 1, 5, 3, 4);

say "\nExample 2:";
solution(5, 0, 1, 2, 3, 4);