#!/usr/bin/env raku
use v6;

sub finalPrice(@prices) {
  my @discounts;
  while (my $current = @prices.shift) {
    if (my $lower = @prices.first: * <= $current) {
      $current -= $lower;
    }
    @discounts.push($current);
  }
  return @discounts;
}

sub solution(@prices) {
  say 'Input: @prices = (' ~ @prices.join(', ') ~ ')';
  my @discounts = finalPrice(@prices);
  say 'Output: (' ~ @discounts.join(', ') ~ ')';
}

say "Example 1:";
solution([8, 4, 6, 2, 3]);

say "\nExample 2:";
solution([1, 2, 3, 4, 5]);

say "\nExample 3:";
solution([7, 1, 1, 5]);
