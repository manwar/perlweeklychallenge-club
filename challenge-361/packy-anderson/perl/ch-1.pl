#!/usr/bin/env perl
use v5.40;

sub largest_fibo_le($int) {
  my ($x, $y) = (0, 1);
  while ($y <= $int) {
    ($x, $y) = ($y, $x + $y);
  }
  return $x;
}

sub zeckendorf($int) {
  # the largest element is the first number
  # in the Zeckendorf form
  my $largest = largest_fibo_le($int);

  return $largest if $largest == $int;

  # if we need more elements, use recursion to find them
  return ( $largest, zeckendorf( $int - $largest ) );
}

sub solution($int) {
  say qq/Input: \$int = $int/;
  my @z = zeckendorf($int);
  say 'Output: ' . join(',', @z);
  say "\n$int => " . join(' + ', @z);
}

say "Example 1:";
solution(4);

say "\nExample 2:";
solution(12);

say "\nExample 3:";
solution(20);

say "\nExample 4:";
solution(96);

say "\nExample 5:";
solution(100);
