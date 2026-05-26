#!/usr/bin/env perl
use v5.40;

sub k_beauty($num, $k) {
  my $count = 0;
  for my $i ( 0..(length($num) - $k)) {
    $count++ if $num % substr($num, $i, $k) == 0;
  }
  $count;
}

sub solution($num, $k) {
  say qq/Input: \$num = $num, \$k = $k/;
  say 'Output: ' . k_beauty($num, $k);
}

say "Example 1:";
solution(240, 2);

say "\nExample 2:";
solution(1020, 2);

say "\nExample 3:";
solution(444, 2);

say "\nExample 4:";
solution(17, 2);

say "\nExample 5:";
solution(123, 1);
