#!/usr/bin/env raku
use v6;

sub pythagMult($n) {
  my $count = 0;
  my $sn = ($n ** 2 / 2).sqrt.Int;
  for 1 .. $sn -> $a {
    for $a + 1 .. $n -> $b {
      my $c = ($a ** 2 + $b ** 2).sqrt;
      last if $c > $n;
      $count += 2 if $c == $c.Int;
    }
  }
  return $count;
}

sub solution($n) {
  say qq/Input: \$n = $n/;
  say 'Output: ' ~ pythagMult($n);
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
