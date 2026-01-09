#!/usr/bin/env perl
use v5.40;

sub minAbsDiff(@ints) {
  # sort so minimum difference items are next to each other
  # ensure numeric sorting
  @ints = sort { $a <=> $b } @ints;
  # start with the largest possible difference
  my $min = abs($ints[-1] - $ints[0]);

  my @pairs;
  my $last = shift @ints;

  foreach my $current (@ints) {
    my $diff = abs($current - $last);
    my $pair = "[$last, $current]";
    if ($diff == $min) { # same diff, add to list
      push @pairs, $pair;
    }
    elsif ($diff < $min) { # start new list with this pair
      @pairs = ($pair);
      $min = $diff;
    }
    $last = $current;
  }
  return join(', ', @pairs);
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  say 'Output: ' . minAbsDiff(@$ints);
}

say "Example 1:";
solution([4, 2, 1, 3]);

say "\nExample 2:";
solution([10, 100, 20, 30]);

say "\nExample 3:";
solution([-5, -2, 0, 3]);

say "\nExample 4:";
solution([8, 1, 15, 3]);

say "\nExample 5:";
solution([12, 5, 9, 1, 15]);

