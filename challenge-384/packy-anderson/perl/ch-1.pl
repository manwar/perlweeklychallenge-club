#!/usr/bin/env perl
use v5.44;

sub baseN($num, $base) {
  my @chars = (0..9,'A'..'Z','a'..'z','+','/')[0..$base-1];
  my @powers;
  my $pow = 0;
  while ($base ** $pow < $num) {
    unshift @powers, $base ** $pow++;
  }
  my ($result, $d);
  for my $pow ( @powers ) {
    ($d, $num) = (int($num / $pow), $num % $pow);
    $result .= $chars[$d];
  }
  $result;
}

sub solution($num, $base) {
  say qq{Input: \$num = $num, \$base = $base};
  say 'Output: ' . baseN($num, $base);
}

say "Example 1:";
solution(42, 2);

say "\nExample 2:";
solution(15642094, 16);

say "\nExample 3:";
solution(493, 8);

say "\nExample 4:";
solution(2228519, 36);

say "\nExample 5:";
solution(123456789, 64);
