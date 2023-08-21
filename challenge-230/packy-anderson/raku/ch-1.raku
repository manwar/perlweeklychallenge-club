#!/usr/bin/env raku

use v6;

sub display_array (@array) {
  return "(" ~ @array.join(q{, }) ~ ")";
}

sub solution (*@ints where {$_.all ~~ Int}) {
  say "Input: \@ints = " ~ display_array(@ints);
  # the description says that the array is positive integers,
  # so let's treat them as integers and divide them
  my @digits_in_array;
  for @ints -> $value {
    my $int = Int.new($value);
    my @digits_of_int;
    while ( $int > 0 ) {
      # first get the ones place digit
      my $ones_place = $int % 10;
      # push it onto the BEGINNING of @digits_of_int
      unshift @digits_of_int, $ones_place;
      # divide the number by 10, discarding the fraction
      $int = ($int / 10).truncate;
    }
    # append the elements from @digits_of_int onto the end
    # of @digits_in_array
    @digits_in_array.append: @digits_of_int;
  }
  say "Output: " ~ display_array(@digits_in_array);
}

say "Example 1:";
solution(1, 34, 5, 6);

say "";

say "Example 2:";
solution(1, 24, 51, 60);
