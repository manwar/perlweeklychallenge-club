#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub isSameLength($A, $B) {
  length($A."") == length($B."");
}

sub isPair($A, $B) {
  join('', sort split //, $A) eq join('', sort split //, $B);
}

sub hasShufflePair($A, $min) {
  my $count = 0;
  my $k = 2;
  while (1) {
    my $B = $A * $k++;
    # stop processing $A if $B has more digits than $A
    return 0 unless isSameLength($A, $B);

    # go to the next $k if $A & $B aren't combinations
    # of the same digits
    next unless isPair($A, $B);

    # it's a shuffle pair, count it
    if (++$count >= $min) {
      # abort searching if we found the minimum count of pairs
      return 1;
    }
  }
  return 0;
}

sub shufflePairs($from, $to, $count) {
  sum(map { hasShufflePair($_, $count) } $from .. $to);
}

sub solution($from, $to, $count) {
  say "Input: \$from = $from, \$to = $to, \$count = $count";
  say 'Output: ' . shufflePairs($from, $to, $count);
}

say "Example 1:";
solution(1, 1000, 1);

say "\nExample 2:";
solution(1500, 2500, 1);

say "\nExample 3:";
solution(1_000_000, 1_500_000, 5);

say "\nExample 4:";
solution(13_427_000, 14_100_000, 2);

say "\nExample 5:";
solution(1030, 1130, 1);

