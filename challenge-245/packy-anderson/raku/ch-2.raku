#!/usr/bin/env raku
use v6;

sub largestOfThree(@ints) {
  my $max = -1; # initialize our failure case
  for @ints.combinations -> @combo {
    next unless @combo.elems > 0; # not empty set
    # sort the digits in descending order,
    # join them, then convert to an Int
    my $num = @combo.sort.reverse.join('').Int;
    next unless $num > $max;   # not bigger than current max
    next unless $num % 3 == 0; # not divisible by 3
    $max = $num;
  }
  return $max;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my $output = largestOfThree(@ints);
  say 'Output: ' ~ $output;
}

say "Example 1:";
solution([8, 1, 9]);

say "\nExample 2:";
solution([8, 6, 7, 1, 0]);

say "\nExample 3:";
solution([1]);
