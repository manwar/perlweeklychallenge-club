#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( first );

sub finalPrice(@prices) {
  my @discounts;
  while (my $current = shift @prices) {
    if (my $lower = first { $_ <= $current} @prices) {
      $current -= $lower;
    }
    push @discounts, $current;
  }
  return @discounts;
}

sub solution($prices) {
  say 'Input: @prices = (' . join(', ', @$prices) . ')';
  my @discounts = finalPrice(@$prices);
  say 'Output: (' . join(', ', @discounts) . ')';
}

say "Example 1:";
solution([8, 4, 6, 2, 3]);

say "\nExample 2:";
solution([1, 2, 3, 4, 5]);

say "\nExample 3:";
solution([7, 1, 1, 5]);
