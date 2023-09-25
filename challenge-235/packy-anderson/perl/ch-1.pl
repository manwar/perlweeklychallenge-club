#!/usr/bin/env perl
 
use v5.38;

sub isStrictlyIncreasing {
  my @ints = @_;
  # get the first integer from the list
  my $last_int = shift @ints;
  # test to make sure each subsequent int is greater
  foreach my $this_int ( @ints ) {
    return 0 if $this_int <= $last_int;
    $last_int = $this_int;
  }
  return 1;
}

sub isStrictlyIncreasingExceptOne {
  my @ints = @_;

  # the list cannot be strictly increasing unless
  # there are at least two items in it
  return 0 if @ints <= 1;

  # if it's strictly increasing without removing
  # an item, it fails the test
  return 0 if isStrictlyIncreasing(@ints);

  # loop over the list by index
  for (my $i = 1; $i <= $#ints; $i++) {
    if ($ints[$i] <= $ints[$i - 1]) {
      # remove the bigger item from the list
      splice(@ints, $i-1, 1);
      # after removing the element, is 
      # the list strictly increasing?
      return isStrictlyIncreasing(@ints);
    }
  }
}

sub solution {
  my @ints = @_;
  say 'Input: @ints = (' . join(', ', @ints) . ')';
  my $output = isStrictlyIncreasingExceptOne(@ints);
  say 'Output: ' . ($output ? 'true' : 'false');
}
 
say "Example 1:";
solution(0, 2, 9, 4, 6);
 
say "\nExample 2:";
solution(5, 1, 3, 2);
 
say "\nExample 3:";
solution(2, 2, 3);

say "\nExample 4 from James Curtis-Smith:";
solution(1,2,3,4,1,2,3);