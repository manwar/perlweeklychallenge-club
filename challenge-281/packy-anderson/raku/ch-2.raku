#!/usr/bin/env raku
use v6;

my @knightMoveList = (
  (-2, -1), (-2, +1), (-1, -2), (-1, +2),
  (+2, -1), (+2, +1), (+1, -2), (+1, +2),
);

sub knightMoves($coordinates) {
  my ($letter, $num) = $coordinates.comb;
  my @endpoints;
  for @knightMoveList -> @colRow {
    my ($col, $row) = @colRow;
    my $newcol = ($letter.ord + $col).chr;
    next unless $newcol ge "a" && $newcol le "h";
    my $newrow = $num + $row;
    next unless 1 <= $newrow <= 8;
    @endpoints.push($newcol ~ $newrow);
  }
  return @endpoints;
}

sub leastMoves($start is copy, $end) {
  # trivial case: we're already at the end point
  return ( 0, $end ) if $start eq $end;

  # Ok, we're going to need to search for a solution.

  # Keep track of how many moves it takes to get to
  # a particular position, starting at $start
  my %moves = ( $start => 0 );

  # also keep track of the path to get there
  my %path_to = ( $start => $start );

  # make a queue of starting points
  my @queue = ( $start );

  while ( @queue ) {
    $start = @queue.shift;

    # figure out the valid moves that we haven't been to yet
    my @endpoints = knightMoves($start).grep({
      %path_to{$_}:!exists
    });

    for @endpoints -> $next {
      # build the path to the next endpoint
      %path_to{$next} = %path_to{$start} ~ " -> $next";

      # increment the number of moves it takes to get there
      %moves{$next} = %moves{$start} + 1;

      # have we arrived at our destination
      return ( %moves{$next}, %path_to{$next} ) if $next eq $end;

      # no? then push this space onto our processing queue
      @queue.push: $next;
    }
  }

  # we can't get there from here!
  # (only possible when the chessboard is an odd size)
  return ( -1, "no path found" );
}

sub solution($start, $end) {
  say qq/Input: \$start = '$start', \$end = '$end'/;
  my ($count, $moves) = leastMoves($start, $end);
  say 'Output: ' ~ $count;
  say "\n$moves";
}

say "Example 1:";
solution('g2', 'a8');

say "\nExample 2:";
solution('g2', 'h2');

say "\nExample 3:";
solution('a1', 'h8');
