#!/usr/bin/env raku
use v6;

sub lastVisitor(@ints) {
  my (@seen, @ans);
  my $x = 0;
  for @ints -> $i {
    if ($i > 0) {
      @seen.unshift($i); # insert at front of @seen
    }
    else {
      if ($x < @seen.elems) {   # if $x < len(@seen)
        @ans.push( @seen[$x] ); # append seen[x] to @ans
      }
      else {
        @ans.push( -1 ); # append -1 to @ans
      }
      $x++;
    }
  }
  return @ans;
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  say 'Output: (' ~ lastVisitor(@ints).join(', ') ~ ')';
}

say "Example 1:";
solution([5, -1, -1]);

say "\nExample 2:";
solution([3, 7, -1, -1, -1]);

say "\nExample 3:";
solution([2, -1, 4, -1, -1]);

say "\nExample 4:";
solution([10, 20, -1, 30, -1, -1]);

say "\nExample 5:";
solution([-1, -1, 5, -1]);
