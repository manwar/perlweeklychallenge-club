#!/usr/bin/env raku
use v6;

sub canBuildSquare(@ints) {
  my $side = @ints.sum / 4;
  return False, '-' unless $side == $side.Int;

  # sort the matches in descending length
  @ints = @ints.sort.reverse;

  # if the longest match is longer than the side length,
  # we can't build a square
  return False, '-' if @ints[0] > $side;

  my @sides = ( [], ); # start with one empty side

  while (True) {
    my @unused;
    for @ints -> $match {
      # this match can be added to other matches to make a side
      if ($match + @sides[*-1].sum <= $side) {
        @sides[*-1].push($match); # add to the matches for this side
        if (@sides[*-1].sum == $side && @sides.elems < 4) {
          # if we've made a complete side, and we have < 4 sides
          @sides.push([]); # add a new empty side
        }
      }
      else {
        @unused.push($match); # save match for later
      }
    }
    # exit the loop if we didn't use any matches,
    # or we've used ALL the matches
    if (@unused.elems == @ints.elems || @unused.elems == 0) {
      last;
    }
    # move the unused matches back to the list
    @ints = @unused;
  }

  if (@sides.elems == 4) {
    return True, @sides.map({ .join('+')}).join(', ');
  }
  return False, '-';
}

sub solution(@ints) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';
  my ($result, $sides) = canBuildSquare(@ints);
  say 'Output: ' ~ $result;
  say 'Sides: ' ~ $sides;
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
