#!/usr/bin/env raku
 
use v6;
 
sub duplicateZeros(*@ints where ($_.all ~~ Int)) {
  loop (my $i = 0; $i < @ints.elems; $i++) {
    if (@ints[$i] == 0) {
      @ints.splice($i+1, 0, 0); # insert a 0 at $i+1
      @ints.splice(*-1);        # pop the last element off @ints
      $i++; # skip over the 0 we added!
    }
  }
  return @ints;
}

sub solution(*@ints where ($_.all ~~ Int)) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  @ints = duplicateZeros(@ints);
  say 'Output: (' ~ @ints.join(', ') ~ ')';
}
 
say "Example 1:";
solution(1, 0, 2, 3, 0, 4, 5, 0);
 
say "\nExample 2:";
solution(1, 2, 3);
 
say "\nExample 3:";
solution(0, 3, 0, 4, 5);