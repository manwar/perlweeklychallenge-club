#!/usr/bin/env raku

use v6;

sub display_array (@array) {
  return "(" ~ @array.join(q{, }) ~ ")";
}

sub solution (@array1, @array2, @array3) {
  say "Input: \@array1 = " ~ display_array(@array1);
  say "       \@array2 = " ~ display_array(@array2);
  say "       \@array3 = " ~ display_array(@array3);

  # Return all the elements that are present in at least 2 out
  # of 3 given arrays.  In the sample input, there are arrays
  # where there elements appear multiple times in a given
  # array, so we want to examine only UNIQUE elements, then
  # find elements that occur in more than one array using
  # a hash
  my %occurrences;
  for ( @array1.unique,
        @array2.unique,
        @array3.unique ).flat -> $element {
    %occurrences{$element}++;
  }

  say "Output: " ~ display_array(
    # only include elements that were counted more than once
    %occurrences.keys().grep: { %occurrences{$_} > 1 } 
  ).sort; # sort the resulting array of elements numerically
}

say "Example 1:";
solution(
  (1, 1, 2, 4),
  (2, 4),
  (4,)
);

say "";

say "Example 2:";
solution(
  (4, 1),
  (2, 4),
  (1, 2)
);
