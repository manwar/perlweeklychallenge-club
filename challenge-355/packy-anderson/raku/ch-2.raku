#!/usr/bin/env raku
use v6;

multi mountainArray($up, @ints) {
  my $first = @ints.shift();

  # must be strictly greater than or strictly less than
  return 'false' if $first == @ints[0];

  # the penultimate element > last element
  if (@ints.elems == 1) {
    return 'true' if $first > @ints[0];
    return 'false';
  }

  if (!$up) { # we're going back down
    # so elements from here on out must be >
    return 'false' if $first < @ints[0];
    return mountainArray(0, @ints);
  }
  else { # we've been coming up
    # $first is the peak, head back down
    return mountainArray(0, @ints) if $first > @ints[0];

    # keep going up
    return mountainArray(1, @ints);
  }
}

multi mountainArray(@ints) {
  # arr.length >= 3
  return 'false' unless @ints.elems >= 3;

  # first element < second element
  my $first = @ints.shift();
  return 'false' unless $first < @ints[0];

  # check the rest of the array
  return mountainArray(1, @ints);
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ mountainArray(@ints);
}

say "Example 1:";
solution([1, 2, 3, 4, 5]);

say "\nExample 2:";
solution([0, 2, 4, 6, 4, 2, 0]);

say "\nExample 3:";
solution([5, 4, 3, 2, 1]);

say "\nExample 4:";
solution([1, 3, 5, 5, 4, 2]);

say "\nExample 5:";
solution([1, 3, 2]);

say "\nExample 6:";
solution([1, 5, 4, 3, 2, 1]);
