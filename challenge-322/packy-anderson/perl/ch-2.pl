#!/usr/bin/env perl
use v5.40;

sub rankArray(@ints) {
  my $rank = 0;
  my %rank;
  foreach my $i (sort @ints) {
    next if exists $rank{$i};
    $rank{$i} = ++$rank;
  }
  map { $rank{$_} } @ints;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my @ranks = rankArray(@$ints);
  say 'Output: (' . join(', ', @ranks) . ')';
}

say "Example 1:";
solution([55, 22, 44, 33]);

say "\nExample 2:";
solution([10, 10, 10]);

say "\nExample 3:";
solution([5, 1, 1, 4, 3]);
