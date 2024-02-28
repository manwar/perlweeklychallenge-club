#!/usr/bin/env perl
use v5.38;

use Memoize;
memoize('setBitCount');

sub setBitCount($i) {
  my $count = 0;
  my $bit   = 1;
  while ($bit <= $i) {
    $count++ if $i & $bit; # count if we have this bit set
    $bit <<= 1; # shift bits left, ie 10 becomes 100
  }
  return $count;
}

sub valueSum($k, @ints) {
  my $sum = 0;
  foreach my $i ( 0 .. $#ints ) {
    $sum += $ints[$i] if setBitCount($i) == $k;
  }
  return $sum;
}

sub solution($k, $ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . '), $k = ' . $k;
  say 'Output: ' . valueSum($k, @$ints);
}

say "Example 1:";
solution(1, [2, 5, 9, 11, 3]);

say "\nExample 2:";
solution(2, [2, 5, 9, 11, 3]);

say "\nExample 3:";
solution(0, [2, 5, 9, 11, 3]);
