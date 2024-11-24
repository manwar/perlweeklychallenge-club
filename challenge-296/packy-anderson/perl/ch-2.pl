#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum0 );

sub canBuildSquare(@ints) {
  my $side = sum0(@ints) / 4;
  return "False", '-' unless $side == int($side);

  # sort the matches in descending length
  @ints = reverse sort @ints;

  # if the longest match is longer than the side length,
  # we can't build a square
  return "False", '-' if $ints[0] > $side;

  my @sides = ( [], ); # start with one empty side

  while (true) {
    my @unused;
    foreach my $match ( @ints ) {
      # this match can be added to other matches to make a side
      if ($match + sum0(@{ $sides[-1] }) <= $side) {
        push @{ $sides[-1] }, $match; # add to the matches for this side
        if (sum0(@{ $sides[-1] }) == $side && @sides < 4) {
          # if we've made a complete side, and we have < 4 sides
          push @sides, []; # add a new empty side
        }
      }
      else {
        push @unused, $match; # save match for later
      }
    }
    # exit the loop if we didn't use any matches,
    # or we've used ALL the matches
    if (scalar(@unused) == scalar(@ints) || @unused == 0) {
      last;
    }
    # move the unused matches back to the list
    @ints = @unused;
  }

  if (@sides == 4) {
    return "True", join(', ', map { join('+', @$_) } @sides);
  }
  return "False", '-';
}

sub solution($ints) {
  say 'Input: @ints = (' . join(', ', @$ints) . ')';
  my ($result, $sides) = canBuildSquare(@$ints);
  say 'Output: ' . $result;
  say 'Sides: ' . $sides;
}

say "Example 1:";
solution([1, 2, 2, 2, 1]);

say "\nExample 2:";
solution([2, 2, 2, 4]);

say "\nExample 3:";
solution([2, 2, 2, 2, 4]);

say "\nExample 4:";
solution([3, 4, 1, 4, 3, 1]);

say "\nExample 5:";
solution([3, 4, 2, 4, 3]);