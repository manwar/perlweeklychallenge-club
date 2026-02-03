#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub digitalRoot($int, $persistence = 0) {
  return ($persistence, $int) if $int < 10 ;
  my $sum = sum split //, $int;
  digitalRoot($sum, $persistence + 1);
}

sub solution($int) {
  say "Input: \$int = $int";
  my ($persistence, $root) = digitalRoot($int);
  say "Output: Persistence  = $persistence";
  say "        Digital Root = $root";
}

say "Example 1:";
solution(38);

say "\nExample 2:";
solution(7);

say "\nExample 3:";
solution(999);

say "\nExample 4:";
solution(1999999999);

say "\nExample 5:";
solution(101010);

