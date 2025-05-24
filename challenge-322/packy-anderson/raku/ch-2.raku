#!/usr/bin/env raku
use v6;

sub rankArray(@ints) {
  my $rank = 0;
  my %rank;
  for @ints.sort() -> $i {
    next if %rank{$i}:exists;
    %rank{$i} = ++$rank;
  }
  @ints.map({ %rank{$_} });
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my @ranks = rankArray(@ints);
  say 'Output: (' ~ @ranks.join(', ') ~ ')';
}

say "Example 1:";
solution([55, 22, 44, 33]);

say "\nExample 2:";
solution([10, 10, 10]);

say "\nExample 3:";
solution([5, 1, 1, 4, 3]);
