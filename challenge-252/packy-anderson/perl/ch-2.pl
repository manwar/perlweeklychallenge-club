#!/usr/bin/env perl
use v5.38;

sub uniqueSumZero($n) {
  my @list;
  my $x = 1;
  while ($n > 0) {
    if ($n % 2 == 1) { # $n is odd
      push @list, 0;
      $n--;
    }
    else { # $n is even
      push @list, $x * -1, $x;
      $x++;
      $n -= 2;
    }
  }
  return sort { $a <=> $b } @list;
}

sub solution($n) {
  say 'Input: $n = ' . $n;
  my @list = uniqueSumZero($n);
  say 'Output: (' . join(', ', @list) . ')';
}

say "Example 1:";
solution(5);

say "\nExample 2:";
solution(3);

say "\nExample 3:";
solution(1);