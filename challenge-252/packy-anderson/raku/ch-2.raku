#!/usr/bin/env raku
use v6;

sub uniqueSumZero($input) {
  my $n = $input;
  my @list;
  my $x = 1;
  while ($n > 0) {
    if ($n % 2 == 1) { # $n is odd
      @list.push(0);
      $n -= 1;
    }
    else { # $n is even
      @list.append($x * -1, $x);
      $x += 1;
      $n -= 2;
    }
  }
  return @list.sort;
}

sub solution($n) {
  say 'Input: $n = ' ~ $n;
  my @list = uniqueSumZero($n);
  say 'Output: (' ~ @list.join(', ') ~ ')';
}

say "Example 1:";
solution(5);

say "\nExample 2:";
solution(3);

say "\nExample 3:";
solution(1);