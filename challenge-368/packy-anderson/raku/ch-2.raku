#!/usr/bin/env raku
use v6;

sub primeFactors($number is copy, $mode) {
  my @possible = (2); # if it's even, 2 is a factor
  @possible.append(3, 5 ... sqrt($number)+1); # odd nums up to √$number
  my @factors;
  for @possible -> $i {
    while ($number % $i == 0) {
      @factors.push($i);
      $number /= $i;
    }
  }
  # if $number is prime
  if ($number > 2) {
    @factors.push($number);
  }
  return $mode == 1 ?? @factors.elems !! @factors.unique.elems;
}

sub solution($number, $mode) {
  say 'Input: $number = ' ~ $number;
  say '       $mode = ' ~ $mode;
  say 'Output: ' ~ primeFactors($number, $mode);
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
