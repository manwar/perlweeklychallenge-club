#!/usr/bin/env raku
use v6;

sub specialAverage(@ints) {
  my $min = @ints.min; # ok, using built-in functions to
  my $max = @ints.max; # find min/max rather than a loop
  @ints = @ints.grep({ $_ != $min && $_ != $max });
  return 0 if @ints.elems == 0;
  return @ints.sum / @ints.elems;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: ' ~ specialAverage(@ints);
}

say "Example 1:";
solution([8000, 5000, 6000, 2000, 3000, 7000]);

say "\nExample 2:";
solution([100_000, 80_000, 110_000, 90_000]);

say "\nExample 3:";
solution([2500, 2500, 2500, 2500]);

say "\nExample 4:";
solution([2000]);

say "\nExample 5:";
solution([1000, 2000, 3000, 4000, 5000, 6000]);
