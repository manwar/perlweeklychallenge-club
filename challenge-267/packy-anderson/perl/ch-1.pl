#!/usr/bin/env perl
use v5.38;

use List::Util qw( reduce );

sub productSign(@ints) {
  my $product = reduce { $a * $b } @ints;
  my $sign = $product == 0 ? 0
          : $product/abs($product);
  my $explain = 'The product ' . join(' × ', @ints)
              . " => $product";
  if ($sign < 0) {
    $explain .= " < 0";
  }
  elsif ($sign > 0) {
    $explain .= " > 0";
  }
  return ($sign, $explain);
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my ($sign, $explain) = productSign(@$ints);
  say "Output: $sign\n$explain";
}

say "Example 1:";
solution([-1, -2, -3, -4, 3, 2, 1]);

say "\nExample 2:";
solution([1, 2, 0, -2, -1]);

say "\nExample 3:";
solution([-1, -1, 1, -1, 2]);