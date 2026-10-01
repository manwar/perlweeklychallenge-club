#!/usr/bin/env perl
use v5.44;

sub pythagMult($n) {
  my $count = 0;
  my $sn = int sqrt($n ** 2 / 2);
  for my $a ( 1 .. $sn ) {
    for my $b ( $a + 1 .. $n ) {
      my $c = sqrt($a ** 2 + $b ** 2);
      last if $c > $n;
      $count += 2 if $c == int $c;
    }
  }
  return $count;
}

sub solution($n) {
  say qq/Input: \$n = $n/;
  say 'Output: ' . pythagMult($n);
}

say "Example 1:";
solution(20);

say "\nExample 2:";
solution(7);

say "\nExample 3:";
solution(1);

say "\nExample 4:";
solution(15);

say "\nExample 5:";
solution(30);