#!/usr/bin/env raku
use v6;

sub isZigZag(@nums) {
  # base cases
  return True if @nums.elems == 1;
  return @nums[0] != @nums[1] if @nums.elems == 2;

  # it's not ZigZag if the array isn't ZigZag before last element
  return False unless isZigZag(@nums[0..*-2]);
  return (
    (@nums[*-3] > @nums[*-2] && @nums[*-2] < @nums[*-1])
    ||
    (@nums[*-3] < @nums[*-2] && @nums[*-2] > @nums[*-1])
  );
}

sub longestZigZag(@nums) {
  my (@current, @longest);
  for 0..@nums.end -> $i {
    # put the $i-th element onto the current subset
    @current.push(@nums[$i]);
    if (isZigZag(@current)) {
      if (@current.elems > @longest.elems) {
        @longest = @current;
      }
    }
    else {
      # pull elements off the front until it's ZigZag again
      while (! isZigZag(@current)) {
        @current.shift;
      }
    }
  }
  return (@longest.elems, @longest);
}

sub solution(@nums) {
  say 'Input: @nums = (' ~ @nums.join(', ') ~ ')';
  my ($len, $longest) = longestZigZag(@nums);
  say "Output: $len\n";
  say 'ZigZag subarray: (' ~ $longest.join(', ') ~ ')';
}

say "Example 1:";
solution([9, 4, 2, 10, 7, 8, 8, 1, 9]);

say "\nExample 2:";
solution([1, 7, 4, 9, 2, 5]);

say "\nExample 3:";
solution([1, 2, 3, 4, 5]);

say "\nExample 4:";
solution([4, 4, 4]);

say "\nExample 5:";
solution([10, 20, 15, 12, 18]);
