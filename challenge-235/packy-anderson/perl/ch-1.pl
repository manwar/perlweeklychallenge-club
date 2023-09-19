#!/usr/bin/env perl
 
use v5.38;

sub isStrictlyIncreasingExceptOne {
  my @ints = @_;

  # the list cannot be strictly increasing unless
  # there are at least two items in it
  return 0 if @ints <= 1;

  my $count = 0; # track how many exceptions

  # get the first integer from the list
  my $last_int = shift @ints;

  foreach my $this_int ( @ints ) {
    if ($this_int <= $last_int) {
      if (++$count > 1) {
        # if we have encountered more than one
        # case where the current int is less than
        # or equal to the last int, we can bail
        # out early, because the check fails
        return 0;
      }
    }

    # move the current int to the last int
    $last_int = $this_int;
  }

  # if the count of cases where the list
  # wasn't increasing is equal to one,
  # then we return true, otherwise false
  return $count == 1;
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