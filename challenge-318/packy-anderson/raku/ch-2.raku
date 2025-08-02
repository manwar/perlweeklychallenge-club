#!/usr/bin/env raku
use v6;

sub arrayEquals(@a, @b) {
  return @a.join(',') eq @b.join(',');
}

sub reverseEquals(@source, @target) {
  # deal with the trivial cases
  if (@source.elems != @target.elems) {
    # @source and @target are different lengths
    return (False, "");
  }
  if (arrayEquals(@source, @target)) {
    # they're already the same
    return (True, "");
  }
  # ok, now we start checking subarrays
  for 0..@source.end - 1 -> $i {
    for $i+1..@source.end -> $j {
      my @reversed;
      @reversed = @source[0..$i-1] if $i > 0;
      @reversed.append(@source[$i..$j].reverse);
      @reversed.append(@source[$j+1..@source.end])
        if $j < @source.end;
      return (True, "$i-$j") if arrayEquals(@reversed, @target);
    }
  }
  return (False, "");
}

sub solution(@source, @target) {
  say 'Input: @source = (' ~ @source.join(', ') ~ ')';
  say '       @target = (' ~ @target.join(', ') ~ ')';
  my ($equals, $elements) = reverseEquals(@source, @target);
  say 'Output: ' ~ $equals;
  say "\nReverse elements: " ~ $elements if $elements;
}

say "Example 1:";
solution([3, 2, 1, 4], [1, 2, 3, 4]);

say "\nExample 2:";
solution([1, 3, 4], [4, 1, 3]);

say "\nExample 3:";
solution([2], [2]);
