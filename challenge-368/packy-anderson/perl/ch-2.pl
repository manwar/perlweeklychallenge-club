#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( uniq );

sub primeFactors($number, $mode) {
  my @possible = (2); # if it's even, 2 is a factor
  push @possible, (3, 5 ... sqrt($number)+1); # odd nums up to √$number
  my @factors;
  foreach my $i ( @possible ) {
    while ($number % $i == 0) {
      push @factors, $i;
      $number /= $i;
    }
  }
  # if $number is prime
  if ($number > 2) {
    push @factors, $number;
  }
  return $mode == 1 ? scalar(@factors) : scalar(uniq @factors);
}

sub solution($number, $mode) {
  say 'Input: $number = ' . $number;
  say '       $mode = ' . $mode;
  say 'Output: ' . primeFactors($number, $mode);
}

say "Example 1:";
solution(100061, 0);

say "\nExample 2:";
solution(971088, 0);

say "\nExample 3:";
solution(63640, 1);

say "\nExample 4:";
solution(988841, 1);

say "\nExample 5:";
solution(211529, 0);
