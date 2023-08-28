#!/usr/bin/env perl

use v5.38;

sub display_array {
  return "(" . join(q{, }, @_) . ")";
}

sub solution {
  my @ints = @_;
  say "Input: \@ints = " . display_array(@ints);
  # the description says that the array is positive integers,
  # so let's treat them as integers and divide them
  my @digits_in_array;
  foreach my $int ( @ints ) {
    my @digits_of_int;
    while ( $int > 0 ) {
      # first get the ones place digit
      my $ones_place = $int % 10;
      # push it onto the BEGINNING of @digits_of_int
      unshift @digits_of_int, $ones_place;
      # divide the number by 10, discarding the fraction
      $int = int( $int / 10 );
    }
    # push the elements from @digits_of_int onto the end
    # of @digits_in_array
    splice @digits_in_array, scalar(@digits_in_array), 0, @digits_of_int;
  }
  say "Output: " . display_array(@digits_in_array);
}

say "Example 1:";
solution(1, 34, 5, 6);

say "";

say "Example 2:";
solution(1, 24, 51, 60);
