#!/usr/bin/env perl
use v5.40;

sub lastVisitor(@ints) {
  my (@seen, @ans);
  my $x = 0;
  foreach my $i ( @ints ) {
    if ($i > 0) {
      unshift @seen, $i; # insert at front of @seen
    }
    else {
      if ($x < @seen) {   # if $x < len(@seen)
        push @ans, $seen[$x]; # append seen[x] to @ans
      }
      else {
         push @ans, -1; # append -1 to @ans
      }
      $x++;
    }
  }
  return @ans;
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: (' . join(', ', lastVisitor(@$ints)) . ')';
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
